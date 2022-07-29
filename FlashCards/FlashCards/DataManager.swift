//
//  DataManager.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 29/07/2022.
//

import Foundation

protocol DataManagerProtocol {
    var cards: [Card] {get}
    func loadData() -> [Card]
    func saveData(_ cards: [Card])
}

class DataManager: ObservableObject {
    
    static let shared = DataManager(LocalFileDataManager())
//    static let shared = DataManager(UserDefaultsDataManager())
    
    @Published var cards: [Card] = []
    
    private var manager: DataManagerProtocol
    
    init(_ manager: DataManagerProtocol) {
        self.manager = manager
        cards = manager.cards
    }
    
    func addCard(_ card: Card) {
        cards.insert(card, at: 0)
        manager.saveData(cards)
    }
    
    func deleteCard(withID id: UUID) {
        if let index = cards.firstIndex(where: {$0.id == id}) {
            cards.remove(at: index)
            manager.saveData(cards)
        }
    }
}

class UserDefaultsDataManager: DataManagerProtocol {
    
    var cards: [Card] = []
    
    init() {
        cards = loadData()
    }
    
    func saveData(_ cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    
    func loadData() -> [Card] {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        return []
    }
}

class LocalFileDataManager: DataManagerProtocol {
    var cards: [Card] = []
    
    private  let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData").appendingPathExtension("json")
    
    init() {
        cards = loadData()
    }
    
    func loadData() -> [Card] {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Card].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
    func saveData(_ cards: [Card]) {
        do {
            let data = try JSONEncoder().encode(cards)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
}

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

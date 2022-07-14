//
//  DataManager.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    var memories: [Memory] = [] {
        didSet {
            save()
        }
    }

    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedMemories")
    
    init() {
        self.memories = loadData()
    }
    
    func loadData() -> [Memory] {
        do {
            let data = try Data(contentsOf: savePath)
            let memories = try JSONDecoder().decode([Memory].self, from: data)
            return memories
        } catch {
            print("Couldn't load data")
            return []
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(memories)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    func addNewMemory(_ memory: Memory) {
        var tempMemories = memories
        tempMemories.append(memory)
        memories = tempMemories
    }
    
    func deleteMemory(withID id: UUID) {
        if let index = memories.firstIndex(where: {$0.id == id}) {
            memories.remove(at: index)
        }
    }

}

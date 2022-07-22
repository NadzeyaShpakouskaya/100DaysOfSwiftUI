//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Nadzeya Shpakouskaya on 19/07/2022.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var date = Date.now
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    @Published var sortingOrder: SortingOrder = .dateAscending
    
 // save data to UserDefaults
    
//    let saveKey = "SavedData"
//
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//        people = []
//    }
//
//    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
//    }
    
    // save data to local JSON file
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData").appendingPathExtension("json")
    
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            people = decoded.sorted { $0.date < $1.date }
        } catch {
            people = []
        }
        
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    
    func toggle(_ prospect: Prospect) {
        // we should use it before changes
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func toggle (_ sortingOrder: SortingOrder) {
        objectWillChange.send()
        sorted(by: sortingOrder)
    }
    
    func sorted(by order: SortingOrder) {
        switch order {
        case .nameAscending:
           people = people.sorted { $0.name < $1.name }
            sortingOrder = .nameAscending
        case .dateDescending:
            people = people.sorted { $0.date > $1.date }
            sortingOrder = .dateDescending
        case .dateAscending:
            people = people.sorted { $0.date < $1.date }
            sortingOrder = .dateAscending
        }
    
    }
}

enum SortingOrder {
    case nameAscending, dateDescending, dateAscending
}

//
//  DataManager.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var memories: [Memory] = []

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

    func save(memories: [Memory]) {
        do {
            let data = try JSONEncoder().encode(memories)
            // write data with protection
            // .completeFileProtection - An option to make the file accessible only while the device is unlocked.
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
//
    func save() {
        do {
            let data = try JSONEncoder().encode(memories)
            // write data with protection
            // .completeFileProtection - An option to make the file accessible only while the device is unlocked.
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
    func addNewMemory(_ memory: Memory) {
        var tempMemories = loadData()
        tempMemories.append(memory)
        memories = tempMemories
        save()

    }
}

//
//  DataManager.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 11/08/2022.
//

import Foundation

class DataManager: ObservableObject {
    private let resultsKey = "results"
     
    @Published var results = [RollResult]() {
        didSet {
            saveResults()
        }
    }
    
    init() {
        results = fetchResults()
    }
    
    private func saveResults() {
        let encoder  = JSONEncoder()
        
        if let data = try? encoder.encode(results) {
            UserDefaults.standard.set(data, forKey: resultsKey)
        }
    }
    
    private func fetchResults() -> [RollResult] {
        guard let data = UserDefaults.standard.data(forKey: resultsKey) else { return []}
        
        let decoder = JSONDecoder()
        
        if let savedResults = try? decoder.decode([RollResult].self, from: data) {
            return savedResults
        }
        return []
    }
}

class LocalFileDataManager: ObservableObject {
    @Published var results = [RollResult]() {
        didSet {
            saveResults()
        }
    }
    
    private  let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData").appendingPathExtension("json")
    
    init() {
        results = loadData()
    }
    
    func loadData() -> [RollResult] {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([RollResult].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
    func saveResults() {
        do {
            let data = try JSONEncoder().encode(results)
            try data.write(to: savePath, options: [.atomic])
        } catch {
            print("Unable to save data.")
        }
    }
    
}

/// File Manager extension allows create folder path in local directory
/// let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData").appendingPathExtension("json")
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

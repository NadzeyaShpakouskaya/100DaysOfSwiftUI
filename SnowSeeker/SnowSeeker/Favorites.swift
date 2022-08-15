//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Nadzeya Shpakouskaya on 14/08/2022.
//

import Foundation

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    
    init() {
        // still here? Use an empty array
        resorts = []
    }
    
    func loadData() {
        // load our saved data
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            resorts = []
            return
        }

        let decoder = JSONDecoder()

        if let savedResults = try? decoder.decode(Set<String>.self, from: data) {
            resorts = savedResults
        }
    }
    
    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        let encoder  = JSONEncoder()
               
               if let data = try? encoder.encode(resorts) {
                   UserDefaults.standard.set(data, forKey: saveKey)
               }
    }
}

//
//  HabitsManager.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import Foundation

class HabitsManager: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            saveHabits()
        }
    }
    
    init() {
        habits = readHabits()
    }
    
    
    private func saveHabits() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(habits) {
            UserDefaults.standard.set(data, forKey: "habits")
        }
    }
    
    private func readHabits() -> [Habit] {
        guard let data = UserDefaults.standard.data(forKey: "habits") else { return [] }
        
        let decoder = JSONDecoder()
        if let savedItems = try? decoder.decode([Habit].self, from: data) {
            return savedItems
        }
        
        return []
    }
}

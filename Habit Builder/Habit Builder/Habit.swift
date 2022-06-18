//
//  Habit.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var type: String
    var daysInRow: Int
    
    static var testHabit = Habit(title: "Read a book", description: "Read 10 pages per day", type: "Other", daysInRow: 5)
    
    static var types = ["Work", "Health", "Family", "Money", "Other"]
}

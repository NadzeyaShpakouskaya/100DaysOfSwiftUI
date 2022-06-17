//
//  Habit.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var type: String
    var daysInRow: Int
}

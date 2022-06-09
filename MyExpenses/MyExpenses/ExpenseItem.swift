//
//  ExpenseItem.swift
//  MyExpenses
//
//  Created by Nadzeya Shpakouskaya on 08/06/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let title: String
    let type: String
    let amount: Double
}

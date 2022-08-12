//
//  RollResult.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 10/08/2022.
//

import Foundation

struct RollResult: Codable {
    var id = UUID()
    let results: [Int]
    let diceSides: Int
    
    var numberOfDices: Int {
        results.count
    }
    
}

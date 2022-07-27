//
//  Card.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import Foundation

struct Card: Codable {
    let question: String
    let answer: String
    
    static let testCard = Card(question: "What is the highest building in the world?", answer: "Burj Khalifa")
}

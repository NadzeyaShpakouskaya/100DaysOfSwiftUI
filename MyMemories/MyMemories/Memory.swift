//
//  Memory.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation
import CoreLocation

struct Memory: Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let date: Date
    var image: Data?
    
    
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
        
        var coordinates: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
               latitude: latitude,
               longitude: longitude)
        }
    }
    
    static func <(lhs: Memory, rhs: Memory) -> Bool {
        lhs.name < rhs.name
    }
    
    static let testMemory = Memory(id: UUID(), name: "My home", description: "this is my own home", date: Date.now,  image: nil)
    
    static let testListOfMemories = [
        Memory(id: UUID(), name: "My home", description: "this is my own home", date: Date.now),
        Memory(id: UUID(), name: "My work", description: "this is my work place", date: Date.now),
        Memory(id: UUID(), name: "My son's school", description: "this is my son's school", date: Date.now)
    
    ]
}

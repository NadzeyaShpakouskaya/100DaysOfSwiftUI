//
//  Memory.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import Foundation
import CoreLocation

struct Memory: Codable, Equatable, Comparable {
    var id: UUID
    var name: String
    var description: String
    let date: Date
    var image: Data?
    var location: Location?
    
    
    
    struct Location: Codable, Equatable {
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
    
    static let testMemory = Memory(
        id: UUID(),
        name: "",
        description: "",
        date: Date.now,
        image: nil,
        location: Location(latitude: 54.12, longitude: -0.124)
    )
    
}

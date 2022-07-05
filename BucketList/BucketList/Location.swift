//
//  Location.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var title: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
           latitude: latitude,
           longitude: longitude)
    }
    
    static let testLocation = Location(
        id: UUID(),
        title: "Buckingham Palace",
        description: "Where Queen Elizabeth lives with her dorgis.",
        latitude: 51.501,
        longitude: -0.141
    )
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

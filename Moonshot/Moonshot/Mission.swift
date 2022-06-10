//
//  Mission.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 10/06/2022.
//

import Foundation



struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var dateLaunching: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    // We keep it nested to be more organized
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}



//
//  Astronaut.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 10/06/2022.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    
    static var testAstronaut = Astronaut(id: "white", name: "Edward H. White II", description: "Edward Higgins White II (November 14, 1930 – January 27, 1967) (Lt Col, USAF) was an American aeronautical engineer, U.S. Air Force officer, test pilot, and NASA astronaut. On June 3, 1965, he became the first American to walk in space. White died along with astronauts Virgil \"Gus\" Grissom and Roger B. Chaffee during prelaunch testing for the first crewed Apollo mission at Cape Canaveral.\n\nHe was awarded the NASA Distinguished Service Medal for his flight in Gemini 4 and was then awarded the Congressional Space Medal of Honor posthumously.")
    
}

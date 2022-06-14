//
//  Extension+Bundle.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 10/06/2022.
//

import Foundation

extension Bundle {
    
    // Method allows to decode local file and return generic confirming decodable protocol
    func decode<T:Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("ERROR: Couldn't find a \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ERROR: Couldn't load data from \(file)")
        }
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let fetchedData = try? decoder.decode(T.self, from: data) else {
            fatalError("ERROR: Couldn't decode data from \(file)")
        }
        
        return fetchedData
    }
}

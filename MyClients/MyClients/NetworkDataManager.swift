//
//  NetworkDataManager.swift
//  BoardgamesLovers
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import Foundation
import SwiftUI

class NetworkDataManager {
    
    static var shared = NetworkDataManager()

    func fetchUserList() async  -> [User] {
        print("start loading data...")

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Error: URL is invalid")
            return []
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let fetchedUsers = try? decoder.decode([User].self, from: data) {
                print("data loaded...")
                return fetchedUsers
            }
        } catch {
            print("Invalid data")
        }
        return []
    }

}


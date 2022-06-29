//
//  DataManager.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import CoreData
import SwiftUI

@MainActor class DataManager: ObservableObject {
    let networkManager: NetworkDataManager  = NetworkDataManager.shared
    let localManager: LocalDataManager = LocalDataManager.shared
    
    @Published var dataLoadedAndCached = false
    var dataLoaded = false
    
    
    init()  {}
    
    // fetch data from network
    func fetchUserList() async  -> [User] {
        let data = await networkManager.fetchUserList()
        if !data.isEmpty {
            dataLoaded = true
        }
        return data
    }

    func saveToCoreData() async {
        if !dataLoaded {
            let data = await fetchUserList()
            
            if !data.isEmpty {
                // transform data to CoreData Entities
                for user in data {
                    let cachedUser = CachedUser(context: localManager.container.viewContext)
                    cachedUser.id = user.id
                    cachedUser.name = user.name
                    cachedUser.address = user.address
                    cachedUser.registered = user.registered
                    cachedUser.email = user.email
                    cachedUser.age = Int16(user.age)
                    cachedUser.about = user.about
                    cachedUser.tags = user.tags.joined(separator: ",")
                    cachedUser.company = user.company
                    cachedUser.isActive = user.isActive
                    for friend in user.friends {
                        let cachedFriend  = CachedFriend(context: localManager.container.viewContext)
                        cachedFriend.id = friend.id
                        cachedFriend.name = friend.name
                        cachedUser.addToFriends(cachedFriend)
                    }
                }
            }
            
            localManager.saveContext()
            dataLoadedAndCached = true

        }
    }
    
}



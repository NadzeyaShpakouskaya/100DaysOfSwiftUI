//
//  DataManager.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import CoreData
import SwiftUI

class DataManager: ObservableObject {
    let networkManager: NetworkDataManager  = NetworkDataManager.shared
    @Environment(\.managedObjectContext) var moc
    @Published var dataLoaded = false
    
    init()  {}
    
    // fetch data from network
    @MainActor  func fetchUserList() async  -> [User] {
        let data = await networkManager.fetchUserList()
        if !data.isEmpty {
            dataLoaded = true
        }
        return data
    }
      
    // TO DO - Need to fix, can't use this method
    // get an error -
    // nilError: The operation couldn’t be completed. (Foundation._GenericObjCError error 0.)
    @MainActor func saveToCoreData() async {
        if !dataLoaded {
            let data = await fetchUserList()
            
            if !data.isEmpty {
                // transform data to CoreData Entities
                for user in data {
                    let cachedUser = CachedUser(context: moc)
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
                        let cachedFriend  = CachedFriend(context: moc)
                        cachedFriend.id = friend.id
                        cachedFriend.name = friend.name
                        cachedUser.addToFriends(cachedFriend)
                    }
                }
            }
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch {
                    print("\(error): \(error.localizedDescription)")
                }
                print("caching ended...")
            }
        }
    }
    
}



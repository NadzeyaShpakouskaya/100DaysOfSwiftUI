//
//  LocalUserListView.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import SwiftUI

struct LocalUserListView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        NavigationView {
            VStack {
                GenericCoreDataList { (user: CachedUser) in
                    UserRow(user: user)
                }
            }.task {

                await saveToCoreData()
// need to fix - see description in DataManger
//               await dataManager.saveToCoreData()
            }.navigationTitle("My clients")
        }
    }
    
    func saveToCoreData() async {
        if !dataManager.dataLoaded {
            let data = await dataManager.fetchUserList()
            
            if !data.isEmpty {
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

struct UserRow: View {
    let user: CachedUser
    
    var body: some View {
        NavigationLink  {
            DetailedTabView(user: user)
        } label: {
            HStack{
                Label("\(user.wrappedName)", systemImage: "network")
                    .foregroundColor(user.isActive ? .green : .gray)
            }
        }
    }
}

//struct LocalUserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocalUserListView()
//    }
//}

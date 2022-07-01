//
//  LocalUserListView.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import SwiftUI

struct LocalUserListView: View {
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        NavigationView{
            VStack {
                Group{
                    if !dataManager.dataLoadedAndCached {
                        ProgressView()
                    } else {
                        GenericCoreDataList { (user: CachedUser) in
                            UserRow(user: user)
                        }
                    }
                }
            }
            .task {
                await dataManager.saveToCoreData()
            }.navigationTitle("My clients")
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

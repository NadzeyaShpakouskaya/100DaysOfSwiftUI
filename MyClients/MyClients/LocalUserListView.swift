//
//  LocalUserListView.swift
//  MyClients
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import SwiftUI

struct LocalUserListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    @StateObject var dataManager = DataManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    // if data not loaded and cached? show progress view
                    if !dataManager.dataCached {
                        ProgressView()
                    } else {
                        List {
                            ForEach(users, id: \.id) { user in
                                UserRow(user: user)
                            }
                        }
                    }
                }.task {
                    await dataManager.saveToCoreData()
                }.navigationTitle("My clients")
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

//
//  DetailedTabView.swift
//  BoardgamesLovers
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import SwiftUI


struct DetailedTabView: View {
    let user: CachedUser
    
    var body: some View {
        
        TabView {
            UserInfoView(user: user)
                .tabItem {
                    Label("Personal info", systemImage: "list.dash")
                }

            FriendsListView(friends: user.friendsList)
                .tabItem {
                    Label("Partners", systemImage: "person.3")
                }
            
            UserTagsView(user: user)
                .tabItem {
                    Label("Tags", systemImage: "tag")
                }
            
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "network")
                    .foregroundColor(user.isActive ? .green : .gray)
            }
        }
    }
}

struct UserInfoView: View {
    let user: CachedUser
    
    var body: some View {
        VStack{
            List{
                Section {
                    Text(user.wrappedEmail)
                } header: {
                    Text("Email:")
                }
                Section {
                    Text("\(user.wrappedAge)")
                } header: {
                    Text("Age:")
                }
                
                Section {
                    Text(user.wrappedCompany)
                } header: {
                    Text("Company:")
                }
                
                Section {
                    Text(user.wrappedAddress)
                } header: {
                    Text("Address:")
                }
                
                Section {
                    Text("\(user.wrappedRegistered.formatted(date: .abbreviated, time: .shortened))")
                } header: {
                    Text("Registration Date:")
                }
                
                Section {
                    Text(user.wrappedAbout)
                } header: {
                    Text("Description:")
                }
            }
        }
    }
}

struct UserTagsView: View {
    let user: CachedUser
    
    var body: some View {
        VStack{
            List(user.wrappedTags, id:\.self) { tag in
                TagView(title: tag).padding(8)
                    .listRowSeparator(.hidden)
            }
            
        }
    }
}

struct TagView: View {
    let title: String
    let colors:[Color] = [.gray, .red, .green, .orange, .indigo]
    
    var body: some View {
        Text(title)
            .font(.headline).bold()
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(colors.randomElement() ?? .cyan)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.white,lineWidth: 2)
                    .shadow(color: .gray, radius: 1, x: 0, y: 0)
            )
    }
}



struct FriendsListView: View {
    let friends: [CachedFriend]
    
    var body: some View {
        VStack{
            List(friends, id: \.id) { friend in
                Text("\(friend.wrappedName)")
            }
        }
    }
}

//struct DetailedTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedTabView(user: User.testUser)
//    }
//}

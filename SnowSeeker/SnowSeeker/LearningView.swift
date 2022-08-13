//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Nadzeya Shpakouskaya on 13/08/2022.
//

import SwiftUI

/// Large screen view presentation style
struct LearningView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, World!")
            }
            .navigationTitle("Primary")
            
            Text("Secondary")
            
            Text("One more text view")
        }
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}

// We can use optional item in sheet or alert to present view
// whenever you tap "Tap to present user view" a sheet saying “Taylor Swift” appears.
// As soon as the sheet is dismissed, SwiftUI sets selectedUser back to nil.
struct SheetAlertView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        VStack(spacing: 30){
            Text("Tap to present user view")
                .onTapGesture {
                    selectedUser = User()
                }
            Button("Present alert") {
                isShowingUser.toggle()
                selectedUser = User()
            }
        }
        .sheet(item: $selectedUser) { user in
            Text(user.id)
        }
        
        .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
            Button(user.id) {selectedUser = nil }
        }
        /*
         if we satisfy with only OK button, that dismisses our alert,
         we can remove our OK button from alert,
         it provides by default
         */
        //            .alert("Welcome", isPresented: $isShowingUser) { }
    }
}

// groups as transparent layout containers
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupsView: View {
    @State private var layoutVertically = false

    var body: some View {
        Group {
            if layoutVertically {
                VStack {
                    UserView()
                }
            } else {
                HStack {
                    UserView()
                }
            }
        }
        .onTapGesture {
            layoutVertically.toggle()
        }
    }
}

// We can use environment parameter sizeClass to detect screen size and organize our views
// all devices have compact or regular horizontal and vertical size depends on screen size
// the smallest has compact, compact, the biggest has regular, regular
struct SizeClassView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            VStack {
                UserView()
            }
        } else {
            HStack {
                UserView()
            }
        }
        
        /*
         shorter version code below
         if sizeClass == .compact {
             VStack(content: UserView.init)
         } else {
             HStack(content: UserView.init)
         }
         */
    }
}

    // MARK: -  Making a SwiftUI view searchable

struct SearchableView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var body: some View {
        NavigationView {
            // we use computed filtered names to present searching results
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            // don't forget to use binding text parameter to update searching
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            // use  $0.localizedCaseInsensitiveContains(searchText) instead of contains to get non-case sensitive results
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GroupsView()
            SheetAlertView()
            LearningView()
            LearningView()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

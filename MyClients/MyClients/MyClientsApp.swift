//
//  MyClientsApp.swift
//  BoardgamesLovers
//
//  Created by Nadzeya Shpakouskaya on 27/06/2022.
//

import SwiftUI

@main
struct MyClientsApp: App {
    @StateObject private var localDataManager = LocalDataManager()    
    
    var body: some Scene {
        WindowGroup {
            LocalUserListView()
                .environment(\.managedObjectContext, localDataManager.container.viewContext)
        }
    }
}

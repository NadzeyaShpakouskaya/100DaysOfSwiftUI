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
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            LocalUserListView(dataManager: dataManager)
                .environment(\.managedObjectContext, localDataManager.container.viewContext)
        }
    }
}

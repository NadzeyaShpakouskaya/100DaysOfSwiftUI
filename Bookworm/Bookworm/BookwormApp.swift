//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Nadzeya Shpakouskaya on 22/06/2022.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
            // put CoreData context to environment 
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}

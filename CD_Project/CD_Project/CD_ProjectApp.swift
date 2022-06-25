//
//  CD_ProjectApp.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//

import SwiftUI

@main
struct CD_ProjectApp: App {
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//            CandiesView()
            // put CoreData context to environment
                .environment(\.managedObjectContext, dataManager.container.viewContext)

        }
    }
}

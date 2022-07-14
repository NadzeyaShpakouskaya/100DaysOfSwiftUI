//
//  MyMemoriesApp.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 11/07/2022.
//

import SwiftUI

@main
struct MyMemoriesApp: App {
    
    @StateObject var dataManager = DataManager.shared
    var body: some Scene {
        WindowGroup {
//            AddMemoryView(viewModel: .init())
            MemoriesListView(dataManager: dataManager)
                .environmentObject(dataManager)
            // switch off warnings in console related to constraints
                .onAppear {
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}

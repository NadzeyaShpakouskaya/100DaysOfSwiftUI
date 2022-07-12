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
        }
    }
}

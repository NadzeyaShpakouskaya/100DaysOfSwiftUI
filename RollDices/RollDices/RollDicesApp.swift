//
//  RollDicesApp.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 10/08/2022.
//

import SwiftUI

@main
struct RollDicesApp: App {
    @StateObject var dataManager = LocalFileDataManager()
    
    var body: some Scene {
        WindowGroup {
            SettingsView()
                .environmentObject(dataManager)
        }
    }
}

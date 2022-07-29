//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 25/07/2022.
//

import SwiftUI

@main
struct FlashCardsApp: App {
    @StateObject var dataManager = DataManager.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(dataManager)
        }
    }
}

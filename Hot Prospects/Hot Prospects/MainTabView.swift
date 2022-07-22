//
//  MainTabView.swift
//  Hot Prospects
//
//  Created by Nadzeya Shpakouskaya on 19/07/2022.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .all)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }.environmentObject(prospects)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

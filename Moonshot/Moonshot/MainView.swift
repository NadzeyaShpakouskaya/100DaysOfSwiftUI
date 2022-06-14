//
//  MainView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 10/06/2022.
//

import SwiftUI

struct MainView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingGrid = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridMissionsView(astronauts: astronauts, missions: missions)
                } else {
                    ListMissionsView(astronauts: astronauts, missions: missions)
                }
            }
            
            .toolbar {
                Button {
                    showingGrid.toggle()
                } label: {
                    Image(systemName: showingGrid ? "list.bullet" :  "square.grid.2x2.fill")
                        .foregroundColor(.white)
                }
                
                
            }
            .navigationTitle("Moonshot")
            .preferredColorScheme(.dark)
            .background(.darkBackground)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  GridMissionsView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 14/06/2022.
//

import SwiftUI

struct GridMissionsView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionCardView(mission: mission)
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GridMissionsView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        GridMissionsView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}

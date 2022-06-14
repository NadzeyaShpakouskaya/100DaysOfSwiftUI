//
//  ListMissionsView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 14/06/2022.
//

import SwiftUI

struct ListMissionsView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    var body: some View {
            List {
                ForEach(missions, id: \.id) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        MissionRowView(mission: mission)
                            .clipShape(Capsule())
   
                    }
                }
                .listRowBackground(Color.darkBackground)
            }

            .listStyle(.plain)

        
    }
}

struct ListMissionsView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListMissionsView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}

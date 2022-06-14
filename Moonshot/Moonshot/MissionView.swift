//
//  MissionView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 13/06/2022.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var splitter: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(height: 2)
            .background(.white.opacity(0.45))
            .padding(.vertical)
    }
    
    var crewView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(.white, lineWidth: 2))
                            
                            VStack (alignment: .leading) {
                                Text(member.astronaut.name)
                                    .font(.headline.bold())
                                    .foregroundColor(.white)
                                Text(member.role)
                                    .foregroundColor(.secondary)
                            }
                        }.padding()
                    }
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
      
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame( maxWidth: geo.size.width * 0.65)
                        .padding(.top)
                    
                    splitter
            
                    VStack(alignment: .leading) {
                        Text("Launch date: \(mission.dateLaunching)")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        splitter
                        Text("Mission highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        splitter
                        Text("Crew members:")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                    }
                    .padding(.horizontal)
                    crewView
                    splitter
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Couldn't find a \(member.name)")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

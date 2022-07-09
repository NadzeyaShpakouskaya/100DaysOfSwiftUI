//
//  MissionCardView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 14/06/2022.
//

import SwiftUI

struct MissionCardView: View {
    let mission: Mission
    
    var body: some View {
        VStack {

            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top)
 

            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(mission.dateLaunching)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }.padding()
            
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.lightBackground, lineWidth: 4)
        )
        .accessibilityElement()
        .accessibilityLabel("\(mission.displayName) \(mission.dateLaunching)")
        .accessibilityAddTraits(.isButton)
    }
}

struct MissionCardView_Previews: PreviewProvider {
    static var previews: some View {
        MissionCardView(mission: Mission.testMission)
            .preferredColorScheme(.dark)
    }
}

//
//  MissionRowView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 14/06/2022.
//

import SwiftUI

struct MissionRowView: View {
    let mission: Mission
    
    var body: some View {
        HStack(spacing: 16) {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.horizontal, 16)
            
            HStack {
                Text(mission.displayName)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Text(mission.dateLaunching)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .background(.lightBackground)
        .accessibilityElement()
        .accessibilityLabel("\(mission.displayName) \(mission.dateLaunching)")
        .accessibilityAddTraits(.isButton)
    }
}


struct MissionRowView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRowView(mission: Mission.testMission)
            .preferredColorScheme(.dark)
    }
}

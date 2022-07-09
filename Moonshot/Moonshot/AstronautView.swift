//
//  AstronautView.swift
//  Moonshot
//
//  Created by Nadzeya Shpakouskaya on 13/06/2022.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground, lineWidth: 4)
                    )
                
                
                Text(astronaut.description)
            }.padding()

        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautView(astronaut: Astronaut.testAstronaut)
            .preferredColorScheme(.dark)
    }
}

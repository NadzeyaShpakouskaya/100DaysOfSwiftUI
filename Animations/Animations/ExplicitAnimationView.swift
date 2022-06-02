//
//  ExplicitAnimationView.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

struct ExplicitAnimationView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation (.interpolatingSpring(stiffness: 3, damping: 1)) {
                animationAmount += 360.0
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        // axes like you look at screw and turn it

        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct ExplicitAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimationView()
    }
}

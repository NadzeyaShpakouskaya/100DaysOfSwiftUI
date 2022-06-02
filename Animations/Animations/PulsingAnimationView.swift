//
//  PulsingAnimationView.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

struct PulsingAnimationView: View {
    @State private var animationAmount = 1.0
    
    
    var body: some View {
        Button("Tap me!") {}
            .padding(50)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2.0 - animationAmount)
                    .animation(
                        .easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: false),
                        value: animationAmount)
            )
            .onAppear {
                animationAmount = 2
            }
    }
}

struct PulsingAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        PulsingAnimationView()
    }
}

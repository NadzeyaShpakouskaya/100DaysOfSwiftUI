//
//  BindingViewsForAnimationView.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

struct BindingViewsForAnimationView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
            // using stepper causing animation for button
       
            Stepper("Scale button",
                    value: $animationAmount.animation(
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                    ),
                    in: 1...10,
                    step: 0.25
            )
                .padding(.horizontal)
            Spacer()
            
            // Tapping button doesn't cause the animation, but size will be increased
            Button("Tap Me") {
                animationAmount += 0.25
            }
            .padding(50)
            .background(.cyan)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            Spacer()
        }.padding(.vertical, 40)
    }
}

struct SecondAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        BindingViewsForAnimationView()
    }
}

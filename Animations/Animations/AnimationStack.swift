//
//  AnimationStack.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

/// describe how important the order of stack modifiers
struct AnimationStack: View {
    @State private var firstButtonEnabled = false
    @State private var secondButtonEnabled = false
    
    var body: some View {
        VStack(spacing: 100) {
            // changing color and changing shape have different animations
            // we switch color and apply animation to shape with new color
            Button("First") {
                firstButtonEnabled.toggle()
            }
            .frame(width: 200, height: 100)
            .background(firstButtonEnabled ? .red : .indigo)
            .animation(.default, value: firstButtonEnabled)
            .clipShape(RoundedRectangle(cornerRadius: firstButtonEnabled ? 20 : 50))
            .animation(.interpolatingSpring(stiffness: 30, damping: 1), value: firstButtonEnabled)
            
            // changing color and changing shape have one animation
            // we switch color and apply animation at the same time
            Button("Second") {
                secondButtonEnabled.toggle()
            }
            .frame(width: 200, height: 100)
            .background(secondButtonEnabled ? .cyan : .green)
            .clipShape(RoundedRectangle(cornerRadius: secondButtonEnabled ? 20 : 50))
            .animation(.interpolatingSpring(stiffness: 30, damping: 1), value: secondButtonEnabled)
        }.foregroundColor(.white)
    }
}

struct AnimationStack_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStack()
    }
}

//
//  GestureAnimation.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

/// describes how to create animation for gestures
/// e.g.: user drag the object
struct GestureAnimation: View {
    @State private var dragAmountForCard = CGSize.zero
    @State private var dragAmountForWords = CGSize.zero
    @State private var wordEnabled = false
    
    let words = Array("SwiftUI Animation")
    
    var body: some View {
        VStack(spacing: 100) {
            // Snake animation for letters
            HStack(spacing: 0) {
                ForEach(0..<words.count) { num in
                    Text(String(words[num]))
                        .padding(2)
                        .font(.title)
                        .background(wordEnabled ? .indigo : .orange)
                        .offset(dragAmountForWords)
                        .animation(
                            .default.delay(Double(num) / 20.0),
                            value: dragAmountForWords)
                }
            }.gesture(
                DragGesture()
                    .onChanged{ dragAmountForWords = $0.translation }
                    .onEnded {_ in
                        dragAmountForWords = .zero
                        wordEnabled.toggle()
                    }
            )
            
            LinearGradient(
                gradient: Gradient(colors: [.yellow, .red]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .offset(dragAmountForCard)
            .gesture(
                DragGesture()
                // view will be moved as our finger
                    .onChanged { dragAmountForCard = $0.translation }
                // when we released finger, it'll take the initial position
                    .onEnded { _ in
                        // we can apply animation only to onEnded using explicit animation
                        /*
                         with animation {
                         dragAmount = .zero
                         }
                         */
                        dragAmountForCard = .zero
                        
                    }
            )
            // we can apply animation to both onChanged and onEnded modifiers
            .animation(.spring(), value: dragAmountForCard)
            
        
        }
    }
}

struct GestureAnimation_Previews: PreviewProvider {
    static var previews: some View {
        GestureAnimation()
    }
}

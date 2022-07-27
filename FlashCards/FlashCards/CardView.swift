//
//  CardView.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    // use closure to notify parent view that card should be removed
    var removal: (() -> Void)?
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var isShowingAnswer = false
    // use offset to animate on drag left/right gesture
    @State private var offset = CGSize.zero
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.question)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                
                Text(card.question)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                if isShowingAnswer {
                Text(card.answer)
                    .font(.title)
                    .foregroundColor(.gray)
                }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        // rotate card depends how far it was moved
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        // make card disappear if it was moved more than 50 points to left or right
        .opacity(2 - Double(abs(offset.width / 50)))
        // voiceOver read card as button and user can interact with it
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged{ gesture in
                    offset = gesture.translation
                    // prepare our haptic notification to reduce delay between haptic and visual effect
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        // remove if it sets in parent view
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }
                        removal?()
                    } else {
                        offset = .zero
                    }
                    
                }
        
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.testCard)
            
    }
}

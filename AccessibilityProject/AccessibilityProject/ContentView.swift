//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Nadzeya Shpakouskaya on 08/07/2022.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
            "ales-krivec-15949",
            "galina-n-189483",
            "kevin-horstmann-141705",
            "nicolas-tissot-335096"
        ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var value = 10
    
    var body: some View {
        VStack{
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
            
            // to ignore VoiceOver
            // .accessibilityHidden() modifier makes view completely invisible to the accessibility system
            Image(decorative: pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .accessibilityHidden(true)
            
            
            
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            // both text views to be read together, but with pause
            .accessibilityElement(children: .combine)
            
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            // child views are invisible to VoiceOver,
            // provide a custom label to the parent
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
            
            VStack {
                Text("Value: \(value)")

                Button("Increment") {
                    value += 1
                }

                Button("Decrement") {
                    value -= 1
                }
            }
            // group all elements in one
            .accessibilityElement()
            // provide custom label for VoiceOver
            .accessibilityLabel("Value")
            // provide value for VoiceOver
            .accessibilityValue(String(value))
            // provide custom actions for VoiceOver
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not handled.")
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Animation stack", destination: AnimationStack())
                NavigationLink("Binding views animation", destination: BindingViewsForAnimationView())
                NavigationLink("Custom transition for animation", destination: CustomTransition())
                NavigationLink("Explicit 3D animation", destination: ExplicitAnimationView())
                NavigationLink("Gesture animation", destination: GestureAnimation())
                NavigationLink("Pulsing animation", destination: PulsingAnimationView())
                NavigationLink("Show and hide animation", destination: ShowHideAnimation())
            }.navigationTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Learning content:") {
                    NavigationLink("Basic shapes") { BasicShapes() }
                    NavigationLink("Animatable data") { AnimatableData() }
                    NavigationLink("Animatable pair") { AnimatablePairView() }
                    NavigationLink("Drawing group") { DrawingGroupView() }
                    NavigationLink("Flower") { FlowerDrawing() }
                    NavigationLink("Effects") { EffectsView() }
                    NavigationLink("Spirograph") { SpirographView() }
                }
                Section("Challenge:") {
                    NavigationLink("Arrow") { ArrowView() }
                    NavigationLink("Color Cycling Rectangle") { ColorCyclingRectView() }
                }
            }.navigationTitle("Drawing examples")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

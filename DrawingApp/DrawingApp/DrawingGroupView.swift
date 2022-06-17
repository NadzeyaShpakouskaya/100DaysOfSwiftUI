//
//  DrawingGroupView.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 16/06/2022.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
 
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)],
                            startPoint: .top,
                            endPoint:.bottom),
                        lineWidth: 4
                    )
            }
        }
        .drawingGroup()
    }
    
    private func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupView: View {
    @State private var colorCycle = 0.0
    @State private var startX = 0.0
    @State private var startY = 0.0
    @State private var endX = 0.0
    @State private var endY = 1.0
    
    
    var body: some View {
        VStack(spacing: 40) {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            HStack {
                Text("Color: ")
                Slider(value: $colorCycle)
            }
        }.padding()
    }
}

struct DrawiingGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupView()
    }
}

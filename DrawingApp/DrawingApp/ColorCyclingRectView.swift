//
//  ColorCyclingRectView.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct ColorCyclingRectView: View {
    @State private var colorCycle = 0.0
    
    @State private var startX = 0.0
    @State private var startY = 0.0
    @State private var endX = 0.0
    @State private var endY = 1.0
    
    var body: some View {
        VStack(spacing: 40) {
            
            ColorCyclingRect(amount: colorCycle)
                .frame(width: 300, height: 300)
            HStack(spacing: 28) {
                    Text("Color: ")
                    Slider(value: $colorCycle)
            }
        }.padding()
    }
}

struct ColorCyclingRect: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [color(for: value, brightness: 1),
                                     color(for: value, brightness: 0.75),
                                     color(for: value, brightness: 0.75),
                                     color(for: value, brightness: 1)
                                     ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing),
                        lineWidth: 10
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


struct ColorCyclingRectView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectView()
    }
}

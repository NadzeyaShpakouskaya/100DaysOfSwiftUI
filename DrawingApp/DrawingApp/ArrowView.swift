//
//  ArrowView.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct ArrowView: View {
    @State private var borderWidth = 10.0

    
    var body: some View {
        VStack(spacing: 50) {
            ArrowShape(borderWidth: borderWidth)
                .stroke(.red, style: StrokeStyle(lineWidth: borderWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 180, height: 300)
                .onTapGesture {
                    withAnimation {
                        borderWidth = Double.random(in: 5...40)
                    }
                }
                
        }
    }
}

struct ArrowShape: Shape {
    var borderWidth: Double
    
    var animatableData: Double {
        get { borderWidth }
        set {borderWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.width * 0.65, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.width * 0.65, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * 0.35, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * 0.35, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height * 0.25))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}

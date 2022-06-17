//
//  AnimatableData.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 16/06/2022.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct AnimatableData: View {
    @State private var inset = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: inset)
            .frame(width: 200, height: 150)
            .onTapGesture {
                withAnimation {
                    inset = Double.random(in: 10...90)
                    
                }
            }
    }
}

struct AnimatableData_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableData()
    }
}

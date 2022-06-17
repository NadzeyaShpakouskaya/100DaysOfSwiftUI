//
//  BasicShapes.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct BasicShapes: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
            Text("Triangle shape")
            TriangleShape()
                .stroke(.red, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
            }.padding()
            .background(.secondary)
            Spacer()
            VStack {
          
            Text("stroke")
            ArcShape(startAngle: .degrees(0), endAngle: .degrees(135), clockwise: true)
                .stroke(.purple, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
          
        }.background(.secondary)
            Spacer()
            VStack {
            Text("strokeBorder")
            ArcShape(startAngle: .degrees(-120), endAngle: .degrees(120), clockwise: true)
                .strokeBorder(.orange, lineWidth: 20)
                .frame(width: 100, height: 100)
            }.background(.secondary)
            Spacer()
        }
    }
}


struct ArcShape: InsettableShape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    // we can use strokeBorder, it conforms InsettableShape protocol
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}


struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct TrianglePath: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            //            path.closeSubpath()
        }
        //        .stroke(.purple, lineWidth: 8)
        .stroke(.purple, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
    }
}

struct BasicShapes_Previews: PreviewProvider {
    static var previews: some View {
        BasicShapes()
    }
}

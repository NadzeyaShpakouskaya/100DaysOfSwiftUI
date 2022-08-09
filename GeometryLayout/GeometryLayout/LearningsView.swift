//
//  ContentView.swift
//  GeometryLayout
//
//  Created by Nadzeya Shpakouskaya on 08/08/2022.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        Text("Hello, world!")
    }
}

struct ScrollEffectsInGRView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        
        // Vertical spiral
            GeometryReader { fullView in
                ScrollView {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(colors[index % 7])
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(height: 40)
                    }
                }
            }
        
        // Horizontal
        
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(1..<20) { num in
                            GeometryReader { geo in
                                Text("Number \(num)")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(.red)
                                    .rotation3DEffect(.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                    .frame(width: 200, height: 200)
                            }
                            .frame(width: 200, height: 200)
                        }
                    }
                }
        }
}

/// Position view in Geometry Reader

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct FramesAndCoordinatesInGeometryReaderView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

/// position modifier takes all available space to position child view correctly
/// offset modifier render view in different place but it position doesn't change
struct AbsolutePositionView: View {
    
    var body: some View {
        // MARK: - Position modifier
        /*
         The view will be with background only for text, because we apply background firstly, and after that position modifier takes all space
         */
        Text("Hello, world!")
            .background(.red)
            .position(x: 100, y: 100)
        
        /*
         The view will be with background for whole screen, because we apply position modifier that takes all available space and after that apply background modifier
         */
        Text("Hello, world!")
            .position(x: 100, y: 100)
            .background(.red)
        
        // MARK: - Offset modifier
        Text("Hello, world!")
            .background(.red)
            .offset(x: 100, y: 100)
        
        Text("Hello, world!")
            .offset(x: 100, y: 100)
            .background(.red)
    }
}


/// We can create and use custom alignment guide to position our views
extension VerticalAlignment {
    
    /// Custom Alignment of views, where you can specify
    /// how views will be arranged
    
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct AlignmentView: View {
    
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center]
                    }
                Image("DefaultImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            
            VStack {
                Text("Created by")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollEffectsInGRView()
//        FramesAndCoordinatesInGeometryReaderView()
        //        AbsolutePositionView()
    }
}

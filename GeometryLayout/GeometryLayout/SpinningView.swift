//
//  SpinningView.swift
//  GeometryLayout
//
//  Created by Nadzeya Shpakouskaya on 09/08/2022.
//

import SwiftUI

struct SpinningView: View {

        let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

        var body: some View {
     
            VStack{
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                  
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Color(
                                    hue: min(1, geo.frame(in: .global).origin.y * 0.95 / fullView.size.height),
                                    saturation: geo.frame(in: .global).origin.y * 1.8 / fullView.size.height,
                                    brightness: 1
                                    )
                                )
                                .rotation3DEffect(
                                    .degrees(geo.frame(in: .global).minY - fullView.size.height / 2.15) / 6,
                                    axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(geo.frame(in: .global).origin.y > 250 ? 1 : geo.frame(in: .global).origin.y / 400)
                                .scaleEffect(
                                    x: max(0.35,
                                        (geo.frame(in: .global).origin.y + fullView.size.height * 0.2) / (fullView.size.height)),
                                    y: max(0.5,
                                           (geo.frame(in: .global).origin.y + fullView.size.height * 0.2) / (fullView.size.height)),
                                    anchor: .center
                                )
                        }
                             
                        
                        .frame(height: 50)
                    }
                }
            }
                
            }
    
        
        }
    
}

struct SpinningView_Previews: PreviewProvider {
    static var previews: some View {
        SpinningView()
    }
}

//
//  EffectsView.swift
//  DrawingApp
//
//  Created by Nadzeya Shpakouskaya on 16/06/2022.
//

import SwiftUI

struct EffectsView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Image("image")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount)
                .blur(radius: (1 - amount) * 20)
            Slider(value: $amount)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct MultiplyEffect: View {
    var body: some View {
        ZStack {
            Image("test_image").resizable().scaledToFit()
                .frame(width: 200, height: 200)
                .colorMultiply(.blue)
        }.ignoresSafeArea()
    }

}

struct RedGreenBlueCirclesView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                // adapted color
//                    .fill(.red)
                // pure color
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
//                    .fill(.green)
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
//                    .fill(.blue)
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }.frame(width: 300, height: 300)
            Slider(value: $amount)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct EffectsView_Previews: PreviewProvider {
    static var previews: some View {
        EffectsView()
        MultiplyEffect()
    }
}

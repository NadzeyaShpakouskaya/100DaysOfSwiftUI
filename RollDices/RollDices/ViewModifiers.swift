//
//  ViewModifiers.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 11/08/2022.
//

import SwiftUI

struct CyanButtonModifier: ViewModifier {
    var size: CGFloat
    var width: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width)
            .padding(.all, size/2)
            .background(.cyan)
            .foregroundColor(.white)
            .font(.system(size: size))
//            .frame(width: width)
            .clipShape(Capsule())
      
    }
}

extension View {
    func cyanButton( fontSize: CGFloat = 16, width: CGFloat = 100) -> some View {
        modifier(CyanButtonModifier(size: fontSize, width: width))
    }
}

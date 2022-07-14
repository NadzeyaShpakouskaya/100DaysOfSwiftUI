//
//  Modifiers.swift
//  MyMemories
//
//  Created by Nadzeya Shpakouskaya on 14/07/2022.
//


import SwiftUI

struct CyanButtonModifier: ViewModifier {
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .padding(.all, size/2)
            .background(.cyan)
            .foregroundColor(.white)
            .font(.system(size: size))
            .clipShape(Capsule())
    }
}

extension View {
    func cyanButton(_ fontSize: CGFloat = 16) -> some View {
        modifier(CyanButtonModifier(size: fontSize))
    }
}

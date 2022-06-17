//
//  Modifiers.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import Foundation
import SwiftUI

struct CyanButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.cyan)
            .foregroundColor(.white)
            .font(.title2.bold().italic())
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(.white, lineWidth: 4)
            )
            .shadow(color: .cyan, radius: 4, x: 4, y: 4)
    }
}

extension View {
    func cyanButton() -> some View {
        modifier(CyanButtonModifier())
    }
}

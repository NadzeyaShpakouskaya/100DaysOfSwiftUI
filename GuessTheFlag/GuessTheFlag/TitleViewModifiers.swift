//
//  TitleViewModifiers.swift
//  GuessTheFlag
//
//  Created by Nadzeya Shpakouskaya on 24/05/2022.
//

import SwiftUI

struct GrayTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.gray)
    }
}

extension View {
    func mainTitle() -> some View {
        modifier(GrayTitle())
    }
}


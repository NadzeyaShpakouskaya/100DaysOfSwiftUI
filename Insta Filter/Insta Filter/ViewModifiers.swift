//
//  ViewModifiers.swift
//  Insta Filter
//
//  Created by Nadzeya Shpakouskaya on 01/07/2022.
//

import SwiftUI

struct DefaultTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 75, alignment: .leading)
            .font(.headline)
    }
}

extension View {
    func appDefaultText() -> some View {
        modifier(DefaultTextModifier())
    }
}

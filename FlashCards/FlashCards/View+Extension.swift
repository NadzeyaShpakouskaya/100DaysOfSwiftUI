//
//  View+Extension.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import SwiftUI

extension View {
    /// display views in stack with visible effect (like deck)
    func stacked(at position: Int, in total: Int) -> some View {
            let offset = Double(total - position)
            return self.offset(x: 0, y: offset * 10)
        }
}

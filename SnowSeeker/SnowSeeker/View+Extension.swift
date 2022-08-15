//
//  View+Extension.swift
//  SnowSeeker
//
//  Created by Nadzeya Shpakouskaya on 13/08/2022.
//

import SwiftUI

extension View {
    // if user uses phone we present our views as stacked view for big screen in landscape mode
    // instead of split view like on iPad
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

//
//  ShowHideAnimation.swift
//  Animations
//
//  Created by Nadzeya Shpakouskaya on 02/06/2022.
//

import SwiftUI

/// show and hide animations
/// the same animation for showing and hiding
/// asymmetric animation for showing and hiding
struct ShowHideAnimation: View {
    @State private var isShowingSameAnimation = false
    @State private var isShowingAsymmetricAnimation = false
    
    var body: some View {
       
            VStack(spacing: 30) {
                Button (isShowingSameAnimation ? "Hide with Animation": "Show with Animation") {
                    withAnimation {
                        isShowingSameAnimation.toggle()
                    }
                }.foregroundColor(.red)
                
                if isShowingSameAnimation {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.red)
                        .frame(width: 200, height: 100)
                        .transition(.scale)
                }
                

                Button(isShowingAsymmetricAnimation ? "Hide with Asymmetric Animation": "Show with Asymmetric Animation") {
                    withAnimation {
                        isShowingAsymmetricAnimation.toggle()
                    }
                }.foregroundColor(.cyan)
                if isShowingAsymmetricAnimation {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.cyan)
                        .frame(width: 200, height: 100)
                        .transition(.asymmetric(insertion: .slide, removal: .opacity))
                }
            }.font(.body.bold())

    
    }
}

struct ShowHideAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideAnimation()
    }
}

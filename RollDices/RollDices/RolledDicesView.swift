//
//  RolledDicesView.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 10/08/2022.
//

import SwiftUI

struct RolledDicesView: View {
    var numberOfDices: Int
    var diceSide: Int
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataManager: LocalFileDataManager
    
    @State private var isRolled = false
    @State private var isResultsSaved = false
    @State private var results = [Int]()

    var body: some View {
        VStack {
            Text("\(diceSide)-sided dices were rolled")
                .font(.title).italic()
                .padding(.top, 50)
            Spacer()
            if isRolled {
                DicesGridView(results: results.map{String($0)})
            } else {
                DicesGridView(results: Array(repeating: "?", count: numberOfDices))
            }
            Spacer()
            Spacer()
            buttonsView
        }.onAppear {
            withAnimation(.easeOut(duration: 1).delay(0.65)) {
                rollDices()
            }
            
        }.alert("Results saved", isPresented: $isResultsSaved) {
            Button(role: .cancel){
                dismiss()
            } label: {
                Text("OK")
            }
        }
    }
    
    var buttonsView: some View {
        HStack(spacing: 20) {
            Button("Back") {
                dismiss()
            }.cyanButton(fontSize: 20, width: 120)
            
            Button("Save results") {
                saveResults()
            }.cyanButton(fontSize: 20, width: 120)
        }.padding(.horizontal, 20)
            .padding(.bottom, 20)
    }
    
    func rollDices() {
        for _ in 0..<numberOfDices {
            let number = Int.random(in: 1...diceSide)
            results.append(number)
        }
        
        isRolled = true
    }
    
    func saveResults() {
        var savedResults = dataManager.results
        let rolledResult = RollResult(results: results, diceSides: diceSide)
        savedResults.append(rolledResult)
        dataManager.results = savedResults
        isResultsSaved = true
    }
    
}

struct DicesGridView: View {
    
    let results: [String]
    var size: CGFloat = 40
    
    let columns = [
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),
        GridItem(.flexible(minimum: 30, maximum: 50)),

    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: size / 1.5) {
            ForEach(0..<results.count) { index in
                Text("\(results[index])")
                    .foregroundColor(.gray)
                    .font(.system(size: size / 2)).bold()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 2)
                        .frame(width: size, height: size))
            }
        }.padding()
    }
}

struct RolledDicesView_Previews: PreviewProvider {
    static var previews: some View {
        RolledDicesView(numberOfDices: 5, diceSide: 10)
    }
}

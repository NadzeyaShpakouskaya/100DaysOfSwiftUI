//
//  SettingsView.swift
//  RollDices
//
//  Created by Nadzeya Shpakouskaya on 10/08/2022.
//

import SwiftUI

enum DicesState {
    case prepared, rolling, rolled
}

enum DiceType: Int, CaseIterable, Identifiable {
    case fourSides = 4
    case sixSides = 6
    case eightSides = 8
    case tenSides = 10
    case twelveSides = 12
    case twentySides = 20
    case hundredSides = 100
    
    static var allCases: [Int] {
        return [fourSides.rawValue, sixSides.rawValue, eightSides.rawValue, tenSides.rawValue, twelveSides.rawValue, twentySides.rawValue, hundredSides.rawValue]
    }
    
    var id: DiceType { self }
}

struct SettingsView: View {
    
    @State private var numberOfDices = 2
    @State private var diceType = DiceType.sixSides
    @State private var isRolledViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack{
                VStack(spacing: 32) {
                    diceTypeView
                    diceQuantityView
                }.font(.headline)
                Spacer()
                rollDicesActionView                
            }
            .padding()
            .navigationTitle("Roll the dices")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isRolledViewPresented) {
                RolledDicesView(numberOfDices: numberOfDices, diceSide: diceType.rawValue)
            }
            .toolbar {
                NavigationLink {
                    SavedResultsView()
                } label: {
                    Image(systemName: "hourglass")
                        .foregroundColor(.cyan)
                }
            }
            .onShake {
                isRolledViewPresented = true
            }
            
        }
    }
    
    var diceTypeView: some View {
        VStack {
            Text("How many sides in your dice?")
            Picker("How many sides in your dices", selection: $diceType) {
                ForEach(DiceType.allCases) { dice in
                    
                    Text("\(dice.rawValue)")
                }.onChange(of: diceType) { newValue in
                    diceType = DiceType(rawValue: newValue.rawValue) ?? .sixSides
                }
                
            }.pickerStyle(.segmented)
        }
    }
    
    var diceQuantityView: some View {
        VStack(alignment: .center) {
            Text("Dices")
            Text("\(numberOfDices)")
                .font(.largeTitle).bold()
            Stepper(
                label: {} ,
                onIncrement: { numberOfDices += 1 },
                onDecrement: {
                if numberOfDices > 1 {
                    numberOfDices -= 1
                }
            }
            ).labelsHidden()
            Spacer()
            
        }.padding(.vertical, 16)
    }
    
    var rollDicesActionView: some View {
        VStack {
            Text("Tap button or shake your device to roll dices")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            
            Button("Roll dices") {
                isRolledViewPresented.toggle()
                
            }.cyanButton(fontSize: 20, width: 120)
        }.font(.headline)
            .padding(.horizontal, 8)
            .padding(.bottom, 20)
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

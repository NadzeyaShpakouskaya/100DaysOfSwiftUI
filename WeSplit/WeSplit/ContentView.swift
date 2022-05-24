//
//  ContentView.swift
//  WeSplit
//
//  Created by Nadzeya Shpakouskaya on 17/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    
    var currencyFormat:  FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle.Currency.currency(code: Locale.current.currencyCode ?? "USD")
    }
    var totalWithTips: Double {
        let percentage = Double(tipPercentage)
        let total = checkAmount * (100.0 + percentage) / 100
        return total
    }
    var totalPerPerson: Double {
        let people = Double(numberOfPeople + 2)
        let perPerson = totalWithTips / people
        return perPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormat)
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Bill Information")
                }
                
                Section {
                    Picker("Percentage of tips", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    HStack{
                    Text(totalWithTips, format: currencyFormat).foregroundColor(tipPercentage == 0 ? .red : .primary)
                        Spacer()
                    Text("Don't be greedy")
                            .foregroundColor(tipPercentage == 0 ? .red : .clear)
                    }
                } header: {
                    Text("Total with tips")
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currencyCode ?? "USD")
                    )
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("We split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

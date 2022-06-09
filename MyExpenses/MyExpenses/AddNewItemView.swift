//
//  AddNewItemView.swift
//  MyExpenses
//
//  Created by Nadzeya Shpakouskaya on 08/06/2022.
//

import SwiftUI

struct AddNewItemView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: Expenses.currencyFormat)
                    .keyboardType(.numbersAndPunctuation)
                
            }.navigationTitle("Add new expense")
                .toolbar {
                    Button(action: addItem) {
                        Text("Save")
                            .frame(width: 60, height: 24)
                            .background(.orange)
                            .clipShape(RoundedRectangle(cornerRadius: 10)).foregroundColor(.white)
                    }
                }
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }
        }
    }
    
    private func addItem() {
        
        guard !title.isEmpty  else {
            enteredValueError(title: "Empty title", message: "Please enter the title of expense")
            return
        }
        
        guard  amount > 0 else {
            enteredValueError(title: "Amount is 0 or less", message: "Please enter the correct amount")
            return
        }
        
        let item = ExpenseItem(title: title, type: type, amount: amount)
        expenses.items.append(item)
        print("\(item.id) - \(item.title) saved.")
        dismiss()
    }
    
    // update and triggered error
    private func enteredValueError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView(expenses: Expenses())
    }
}

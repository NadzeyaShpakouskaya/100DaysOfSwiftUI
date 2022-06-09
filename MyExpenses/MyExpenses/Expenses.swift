//
//  Expenses.swift
//  MyExpenses
//
//  Created by Nadzeya Shpakouskaya on 08/06/2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
           saveItems()
        }
    }
    


    var personalExpenses: [ExpenseItem] {
        items.filter {$0.type == "Personal"}
    }

    var businessExpenses: [ExpenseItem] {
        items.filter {$0.type == "Business"}
    }

    
    init() {
        items = readItems()
    }
    
    private func saveItems() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(items) {
            UserDefaults.standard.set(data, forKey: "items")
        }
    }
    
    private func readItems() -> [ExpenseItem] {
        guard let data = UserDefaults.standard.data(forKey: "items") else { return [] }
        
        let decoder = JSONDecoder()
        if let savedItems = try? decoder.decode([ExpenseItem].self, from: data) {
            return savedItems
        }
        
        return []
    }
    
    func deleteItem(with id: UUID) {
        if let index = items.firstIndex(where: {$0.id == id}) {
            let item = items[index]
            print("\(item.id) - \(item.title) was deleted")
            items.remove(at: index)
        }
    }
}

extension Expenses {
    static var currencyFormat: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle.Currency.currency(code: Locale.current.currencyCode ?? "USD")
    }
}

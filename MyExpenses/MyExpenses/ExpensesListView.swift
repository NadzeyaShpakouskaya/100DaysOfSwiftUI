//
//  ExpensesListView.swift
//  MyExpenses
//
//  Created by Nadzeya Shpakouskaya on 07/06/2022.
//

import SwiftUI

struct ExpensesListView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddNewExpense = false
    
    var body: some View {
        NavigationView {
            sectionList
            .navigationTitle("My Expenses")
            .toolbar {
                Button {
                    showingAddNewExpense = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                }
            }
            .sheet(isPresented: $showingAddNewExpense) {
                AddNewItemView(expenses: expenses)
            }
        }
    }
    
    var sectionList: some View {
        List {
            Section {
                ForEach(expenses.personalExpenses) {    item  in
                    RowView(item: item, colors: (.purple, .cyan, .indigo), boundValues: (50, 100))
                }
                .onDelete(perform: { index in removeItems(at: index, section: 0)})
            } header: {
                SectionHeaderView(title: "🏠 Personal", fontColor: .cyan)
       
            }
            
            Section {
                ForEach(expenses.businessExpenses) {    item  in
                    RowView(item: item, colors: (.red, .orange, .brown), boundValues: (200, 1000))
                }
                .onDelete(perform: { index in removeItems(at: index, section: 1)})
            } header : {
                SectionHeaderView(title: "🏢 Business", fontColor: Color(uiColor: .systemBrown))
            }
        }
    }
    
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    private func removeItems(at offsets: IndexSet, section: Int) {
        guard let index = offsets.first else { return }
        if section == 0 {
            expenses.deleteItem(with: expenses.personalExpenses[index].id)
        } else if section == 1 {
            expenses.deleteItem(with: expenses.businessExpenses[index].id)
        }
    }
    
}

///
///  Row view for Expense item
///
///  colors:  - provide 3  colors for bounded range like (.red, .green, .blue)
///
///  boundValues: - provide 2 values for coloring amount
///
struct RowView: View {
    let item: ExpenseItem
    /// 3 color for bounds
    let colors: (Color, Color, Color)
    let boundValues: (Double, Double)
    
    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            Text(item.amount, format: Expenses.currencyFormat)
                .foregroundColor(item.amount >= boundValues.0 ? item.amount >= boundValues.1 ? colors.0 : colors.1 : colors.2)
                .font(.headline.italic())
        }
        .accessibilityElement()
        .accessibilityLabel("\(item.amount) for \(item.title)")
        .accessibilityHint("\(item.type)")
    }
}

struct SectionHeaderView: View {
    let title: String
    let fontColor: Color
    
    var body: some View {
        Text(title)
            .sectionTitle()
            .foregroundColor(fontColor.opacity(0.8))
    }
}


struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.italic().bold())

    }
}

extension View {
    func sectionTitle() -> some View {
        modifier(Title())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesListView()
    }
}

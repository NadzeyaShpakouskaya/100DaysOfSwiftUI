//
//  HabitsListView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct HabitsListView: View {
    @StateObject var habitsManager = HabitsManager()
    @State private var showingAddNewHabit = false
    
    @State private var showingGrid = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habitsManager.habits, id: \.id) { habit in
                    Text("\(habit.title)")
                }.onDelete(perform: removeItems(at:))
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showingAddNewHabit = true
                    } label: {
                        Image(systemName: "plus")
        
                            .foregroundColor(.cyan)
                    }
                    Spacer()}
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "list.bullet" :  "square.grid.2x2.fill")
                            .foregroundColor(.cyan)
                    }
                }
            }
            
            .sheet(isPresented: $showingAddNewHabit) {
                NewHabitView(manager: habitsManager)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        habitsManager.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView()
    }
}

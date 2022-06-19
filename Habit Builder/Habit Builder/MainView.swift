//
//  MainView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 18/06/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var habitsManager = HabitsManager()
    @State private var showingAddNewHabit = false
    
    @State private var showingGrid = false
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    HabitsGridView(manager: habitsManager)
                } else {
                    HabitsListView(manager: habitsManager)
                }
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
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

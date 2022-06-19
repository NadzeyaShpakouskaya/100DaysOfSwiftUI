//
//  HabitsListView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct HabitsListView: View {
    @ObservedObject var manager: HabitsManager
    
    var body: some View {
        List {
            ForEach(manager.habits, id: \.id) { habit in
                NavigationLink {
                    HabitInfoView(manager: manager, habit: habit)
                } label: {
                    HStack {
                        Text("\(habit.title)")
                            .foregroundColor(.cyan)
                        Spacer()
                        Label("\(habit.daysInRow)", systemImage: "flame")
                            .foregroundColor(.orange)
                    } .font(.title2.bold())
                }
            }.onDelete(perform: removeItems(at:))
        }
    }
    
    
    private func removeItems(at offsets: IndexSet) {
        manager.habits.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView(manager: HabitsManager())
    }
}

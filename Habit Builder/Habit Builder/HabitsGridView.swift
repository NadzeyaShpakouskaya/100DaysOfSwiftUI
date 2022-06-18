//
//  HabitsGridView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 18/06/2022.
//

import SwiftUI

struct HabitsGridView: View {
    @ObservedObject var manager: HabitsManager
    let columns = [ GridItem(), GridItem()]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(manager.habits) { habit in
                    NavigationLink {
                        HabitInfoView(manager: manager, habit: habit)
                    } label: {
                        HabitCardView(habit: habit)
                         
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct HabitCardView: View {
    let habit: Habit
    
    var body: some View {
        VStack {
            Spacer()
            Text(habit.title)
                .foregroundColor(.cyan)
                .font(.title2.bold().italic())
                .lineLimit(2)
                .padding()
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(habit.description)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .font(.subheadline.italic().bold())
                Divider()
                Label("Days: \(habit.daysInRow)", systemImage: "flame")
                    .foregroundColor(.orange)
                    .font(.headline)
                
            }.padding()
                .foregroundColor(.cyan)
                .frame(width: 150, height: 80)
                .background(.cyan.opacity(0.35))
            
        }.frame(width: 150, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(.cyan, lineWidth: 4)
        )
    }
}

struct HabitsGridView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsGridView(manager: HabitsManager())
    }
}

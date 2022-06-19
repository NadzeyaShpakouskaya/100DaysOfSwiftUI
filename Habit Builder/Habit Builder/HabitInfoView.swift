//
//  HabitInfoView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 18/06/2022.
//

import SwiftUI

struct HabitInfoView: View {
    @ObservedObject var manager: HabitsManager
    
    let habit: Habit
    let rows = [GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)),
                GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)), GridItem(.fixed(25)),
    ]

    var body: some View {
        VStack(spacing: 50) {
            infoStackView
            buttonsStackView
            Spacer()
            
        }.padding()
        
        
    }
    
    var infoStackView: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.45))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 5))
                .shadow(color: .gray, radius: 4, x: 4, y: 4)
            
            
            VStack (spacing: 50) {
                Text(habit.title)
                    .font(.largeTitle).bold().italic()
                VStack(alignment: .leading, spacing: 20) {
                    Text(habit.description)
                        .font(.title2.italic())
                        .lineLimit(10)
                    HStack{
                        Text("Days complete:")
                        Spacer()
                        Text("\(habit.daysInRow)")
                    }
                    ScrollView{
                        LazyVGrid(columns: rows) {
                            ForEach(0..<habit.daysInRow, id: \.self) { _ in
                                Label("", systemImage: "flame")
                            }
                        }
                    }
                    
                }.font(.title3.bold())
                
            }
            .foregroundColor(.white)
            .padding()
        }
    }
    
    var buttonsStackView: some View {
        VStack (spacing: 20){
            Button(action: addOneDay) {
                Label("Add one more day", systemImage: "flame")
                    .frame(width: 300)
                    .orangeButton()
                
            }
            Button(action: removeOneDay) {
                Label("Remove one day", systemImage: "snowflake")
                    .frame(width: 300)
                    .cyanButton()
            }
        }
    }
    
    func addOneDay() {
        var temp = habit
        temp.daysInRow += 1
        
        guard let index = manager.habits.firstIndex(of: habit) else {
           print("couldn't add a day")
            return
            
        }
        manager.habits[index] =  temp
    }
    
    func removeOneDay() {
        if habit.daysInRow > 0 {
            var temp = habit
            temp.daysInRow -= 1
            
            guard let index = manager.habits.firstIndex(of: habit) else {
                print("couldn't subtract a day")
                return }
            manager.habits[index] =  temp
        }
    }
    
    func updateHabit() {
        
    }
}

struct HabitInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HabitInfoView(manager: HabitsManager(), habit: Habit.testHabit)
    }
}

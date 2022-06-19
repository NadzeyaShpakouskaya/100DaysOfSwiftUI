//
//  NewHabitView.swift
//  Habit Builder
//
//  Created by Nadzeya Shpakouskaya on 17/06/2022.
//

import SwiftUI

struct NewHabitView: View {
    @ObservedObject var manager: HabitsManager
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var type = "Health"
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
        
    var body: some View {
        ZStack {
            
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            VStack{
                Form {
                    Section{
                        TextField("Make 7-minute exercise", text: $title)
                    } header: {
                        Text("Title:")
                    }
                    
                    Section{
                        TextEditor(text: $description)
                            .frame(height: 100)
                    } header: {
                        Text("Description:")
                    }
                    
                    Section{
                        Picker("Type", selection: $type) {
                            ForEach(Habit.types, id: \.self) {
                                Text("\($0)")
                            }
                        }.pickerStyle(.inline)
                            .labelsHidden()
                    } header: {
                        Text("Type:")
                    }
                    
                    
                }
                HStack{
                    Spacer()
                    Button(action: addHabit) {
                        Text("Add habit")
                            .cyanButton()
                    }
                    Spacer()
                    
                }.padding(.bottom)
            }
        }
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        
    }
    
    private func addHabit() {
        guard !title.isEmpty  else {
            enteredValueError(title: "Empty title", message: "Please enter the title of habit")
            return
        }
        
        guard !description.isEmpty  else {
            enteredValueError(title: "Empty description", message: "Please add some notes or motivation message")
            return
        }
        
        let habit = Habit(title: title, description: description, type: type, daysInRow: 0)
        manager.habits.append(habit)
        dismiss()
        
    }
    
    // update and triggered error
    private func enteredValueError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(manager: HabitsManager())
    }
}

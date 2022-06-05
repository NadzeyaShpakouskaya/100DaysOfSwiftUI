//
//  SettingsView.swift
//  MathTable
//
//  Created by Nadzeya Shpakouskaya on 05/06/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var learningNumber = 0
    @State private var numberOfQuestions = 0
    @State private var gameMode = 0
    
    let numbersOfQuestions = [5, 10, 15, 20]
    init(gameSettings: (Int, Int, Int) -> Void) {
        gameSettings(learningNumber, numberOfQuestions, gameMode)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    Picker("My number is", selection: $learningNumber) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.automatic)
                } header: {
                    Text("Learning number:")
                }
                
                Section {
                    Picker("What is your favorite color?", selection: $numberOfQuestions) {
                        Text("5").tag(0)
                        Text("10").tag(1)
                        Text("15").tag(2)
                        Text("20").tag(3)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Questions in quiz: ")
                }
                
                Section {
                    Picker("What is your favorite color?", selection: $gameMode) {
                        Text("Easy").tag(0)
                        Text("Normal").tag(1)
                        Text("Hard").tag(2)
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Quiz mode:")
                }
                
                Button {
                    //
                } label: {
                    HStack{

                    
                    Text("Start quiz")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
            
        
                    }
                }

            }.navigationTitle("Quiz settings")
        }
    }
    
    func startQuizPressed(gameSettings: (Int, Int, Int) -> Void) {
       gameSettings(learningNumber, numberOfQuestions, gameMode)
    }
    
}

enum GameMode: Int {
    case easy = 0, normal, hard
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {

        SettingsView {_,_,_ in }
    }
}

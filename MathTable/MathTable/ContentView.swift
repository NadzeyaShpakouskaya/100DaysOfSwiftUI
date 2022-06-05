//
//  ContentView.swift
//  MathTable
//
//  Created by Nadzeya Shpakouskaya on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    // Determine what view is present - settings or game
    @State private var isGameStarted = false
    @State private var isGameEnded = false
    
    @State private var learningNumber = 0
    @State private var numberOfQuestions = 0
    @State private var gameMode = 0
    
    @State private var questionsList: [Question] = []
    @State private var currentQuestion = 0
    @State private var correctAnswerCounter = 0
    
    @State private var selectedAnswer = ""
    
    var header: String {
        if !isGameEnded && !isGameStarted {
            return "Quiz settings"
        } else if isGameStarted && !isGameEnded {
            return "Question \(currentQuestion + 1) of \(questions)"
        } else if isGameStarted && isGameEnded {
            return "Results"
        } else {
            return "Oops, something went wrong..."
        }
    }
    
    var questions: Int {
        5 * (numberOfQuestions + 1)
    }
    
    var number: Int {
        learningNumber + 2
    }
    
    var numberOfAnswers: Int {
        gameMode + 2
    }
    
    var body: some View {
        NavigationView {
            Group {
                if !isGameEnded && !isGameStarted {
                    settingsView
                } else if isGameStarted && !isGameEnded {
                    questionView
                } else if isGameEnded && isGameStarted  {
                    resultsView                }
            }.navigationTitle(header)
        }
    }
    
    var settingsView: some View {
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
                Picker("Number of questions in quiz?", selection: $numberOfQuestions) {
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
                startQuizButtonPressed()
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
            
        }
    }
    
    var questionView: some View {
        VStack {
            Text(questionsList[currentQuestion].text)
            ForEach(questionsList[currentQuestion].answers, id: \.self) { answer in
                Button {
                    selectedAnswer = answer
                    checkAnswer()
                } label: {
                    Text(answer)
                        .padding()
                        .background(.cyan)
                        .foregroundColor(.white)
                }
            }
            
      
        }
    }
    
    var resultsView: some View {
        VStack {
            Text("You answered \(correctAnswerCounter) questions correctly.")
            Button("Play again") {
                restartGame()
            }
        }
    }
    
    func checkAnswer() {
        if selectedAnswer == String(questionsList[currentQuestion].correctAnswer) {
            correctAnswerCounter += 1
        }
        showNextQuestion()
    }
    
    func restartGame() {
        isGameStarted = false
        isGameEnded = false
        
        learningNumber = 0
        numberOfQuestions = 0
        gameMode = 0
        
        questionsList = []
        currentQuestion = 0
        correctAnswerCounter = 0
        selectedAnswer = ""
    }
    
    func showNextQuestion() {
        if currentQuestion < questions - 1 {
            currentQuestion += 1
            selectedAnswer = ""
        } else {
            isGameEnded = true
        }
    }
    
    func startQuizButtonPressed() {
        generateQuestions()
        if !questionsList.isEmpty {
            isGameStarted = true
        }
    }
    
    func generateQuestions() {
        for _ in 0..<questions {
            let secondNumber = Int.random(in: 1...12)
            let text = "\(number) x \(secondNumber) = ___"
            let correctAnswer = number * secondNumber
            let answers = generateAnswersFor(number, and: secondNumber)
            let question = Question(text: text, correctAnswer: correctAnswer, answers: answers)
            questionsList.append(question)
        }
        print(questionsList)
    }
    
    func generateAnswersFor(_ number: Int, and secondNumber: Int) -> [String] {
        var answers = [String]()
        answers.append("\(number * secondNumber)")
        answers.append("\((number - 1) * secondNumber)")
        for i in 1..<numberOfAnswers - 1 {
            let answer = "\((i + number) * secondNumber)"
            answers.append(answer)
        }
        return answers.shuffled()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

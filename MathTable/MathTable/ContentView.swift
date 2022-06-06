//
//  ContentView.swift
//  MathTable
//
//  Created by Nadzeya Shpakouskaya on 05/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isGameStarted = false    // Determine what view is present - settings or game
    @State private var isGameEnded = false      // use to show the results of game
    @State private var learningNumber = 0       // selected number to practice
    @State private var gameMode = 0             // game mode: 0 - easy, 1 - normal, 2 - hard
    @State private var questionsList: [Question] = []
    @State private var currentQuestion = 0      // track presenting question
    @State private var correctAnswerCounter = 0 // counter for correct answers
    @State private var selectedAnswer = ""      // track selected answer
    @State private var sliderNumberOfQuestions = 5.0
    @State var answerAlertTitle = ""
    @State var answerAlertMessage = ""
    
    // parameters for animation
    @State private var isQuestionAnswered = false //
    @State private var animationAmount = 0.0
    
        // MARK: - private parameters
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
    
    
    var title: String {
        return  gameMode == 0 ? "🐹" : gameMode == 1 ? "🐸" : "🦁"
    }
    
    var questions: Int { Int(sliderNumberOfQuestions) }
    var number: Int { learningNumber + 2 }
    var numberOfAnswers: Int { gameMode + 2 }
    
    var body: some View {
        NavigationView {
            Group {
                if !isGameEnded && !isGameStarted {
                    settingsView
                } else if isGameStarted && !isGameEnded {
                    questionView
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 1))
                } else if isGameEnded && isGameStarted  {
                    resultsView
                }
            }.navigationTitle(header)
                .alert(answerAlertTitle, isPresented: $isQuestionAnswered) {
                    Button("OK", action: showNextQuestion)
                } message: {
                    Text(answerAlertMessage)
                }
        }
    }
    
        // MARK: - subviews
    var settingsView: some View {
        VStack(spacing: 20) {
            Form {
                Section {
                    Picker("Learning number:", selection: $learningNumber) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }.labelsHidden()
                }
                .font(.title.bold())
                .foregroundColor(.indigo)
                
                
                Section {
                    VStack{
                        HStack {
                            Text("Questions in quiz: ")
                            Spacer()
                            Text("\(sliderNumberOfQuestions.formatted())")
                        }.font(.title.bold())
                        Slider(value: $sliderNumberOfQuestions, in: 5...20, step: 5) {
                        } minimumValueLabel: {
                            Text("5")
                        } maximumValueLabel: {
                            Text("20")
                        }.tint(.cyan)
                    }
                } .foregroundColor(.cyan)
                    .font(.body.bold())
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Quiz mode:")
                        Picker("Select quiz mode", selection: $gameMode) {
                            Text("🐹 Easy").tag(0)
                            Text("🐸 Normal").tag(1)
                            Text("🦁 Hard").tag(2)
                        }
                        .pickerStyle(.segmented)
                    }
                }.font(.title.bold())
                    .foregroundColor(.orange)
            }
            
            Button {
                startQuizButtonPressed()
            } label: {
                HStack {
                    Text("Start quiz")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(.yellow)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(radius: 5)
                }
            }.padding()
            Spacer()
        }
    }
    
    var questionView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.orange.opacity(0.65))
                .padding()
                .shadow(radius: 5)
            
            VStack(spacing: 50) {
                Text(questionsList[currentQuestion].text)
                    .font(.largeTitle.bold())
                VStack(spacing: 16) {
                    ForEach(questionsList[currentQuestion].answers, id: \.self) { answer in
                        Button {
                            isQuestionAnswered = true
                            selectedAnswer = answer
                            withAnimation(.easeInOut(duration: 0.85)) {
                                checkAnswer()
                                animationAmount += 360.0
                            }
                        } label: {
                            Text(answer)
                                .padding()
                                .font(.largeTitle.bold())
                                .frame(width: 200, height: 50)
                                .background(.white)
                                .foregroundColor(.orange)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }.shadow(radius: 4)
                    }
                    
                }
                
            }.opacity(!isQuestionAnswered ? 1 : 0)
                .scaleEffect(!isQuestionAnswered ? 1 : 0.75)
                .foregroundColor(.white)
                
            
        }
        
        
    }
    
    var resultsView: some View {
        VStack (spacing: 50) {
            VStack (spacing: 20) {
                Text(title).font(.system(size: 48))
            Text("likes playing with you")
                .font(.title.bold())
                .foregroundColor(.mint)
            Text("\(correctAnswerCounter) of \( questions) \n answers were correct.")
                .font(.title2.bold())
                .foregroundColor(.secondary)
            }.multilineTextAlignment(.center)
            Spacer()
            Button(action: restartGame) {
                Text("Play again")
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 5)
                    .font(.largeTitle.bold())

            }
            Spacer()
        }.padding()
            
    }

    private func checkAnswer() {
        var title = title
        if selectedAnswer == String(questionsList[currentQuestion].correctAnswer) {
            correctAnswerCounter += 1
            title += " is happy"
            answerAlertMessage =  "\nYou are right!\n"
            
        } else {
            title += " can help you"
            answerAlertMessage =  "Remember!\n\n\(questionsList[currentQuestion].text) \(questionsList[currentQuestion].correctAnswer)"
        }
        answerAlertTitle = title
    }
    
    private func restartGame() {
        isGameStarted = false
        isGameEnded = false
        
        questionsList = []
        currentQuestion = 0
        correctAnswerCounter = 0
        selectedAnswer = ""
    }
    
    private func showNextQuestion() {
        if currentQuestion < questions - 1 {
            currentQuestion += 1
            selectedAnswer = ""
        } else {
            isGameEnded = true
        }
    }
    
    private func startQuizButtonPressed() {
        generateQuestions()
        if !questionsList.isEmpty {
            isGameStarted = true
        }
    }
    
    // generate questions for game
    private func generateQuestions() {
        for _ in 0..<questions {
            let secondNumber = Int.random(in: 1...12)
            let text = "\(number) x \(secondNumber) ="
            let correctAnswer = number * secondNumber
            let answers = generateAnswersFor(number, and: secondNumber)
            let question = Question(text: text, correctAnswer: correctAnswer, answers: answers)
            questionsList.append(question)
        }
    }
    
    // generate answers for 2 numbers
    private func generateAnswersFor(_ number: Int, and secondNumber: Int) -> [String] {
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

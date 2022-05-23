//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nadzeya Shpakouskaya on 20/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var gameEnded = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCounter = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(
                stops: [
                .init(color: .white, location: 0.80),
                .init(color: .mint, location: 0.80)
            ],
                center: .top,
                startRadius: 0,
                endRadius: UIScreen.main.bounds.width / 1.5)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.secondary)
                VStack {
                    Spacer()
                    VStack (spacing: 15) {
                        VStack {
                            Text("Tap the flag of")
                                .font(.headline.weight(.bold))
                            Text("\(countries[correctAnswer])")
                                .font(.largeTitle.weight(.semibold))
                        }.foregroundColor(.secondary)
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(color: .gray, radius: 10, x: -5, y: 5)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                }
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }.alert (scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("Game is over.", isPresented: $gameEnded) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    private func flagTapped(_ number: Int) {
        if correctAnswer == number {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    private func askQuestion() {
        if questionCounter < 7 {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
            questionCounter += 1
        } else {
            gameEnded = true
        }
    }
    
    private func restartGame() {
        score = 0
        questionCounter = 0
        gameEnded = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPod touch"))
                .previewDisplayName("iPod touch")

            ContentView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")
        }
}

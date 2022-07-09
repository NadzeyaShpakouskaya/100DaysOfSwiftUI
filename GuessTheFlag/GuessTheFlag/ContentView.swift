//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nadzeya Shpakouskaya on 20/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isCorrectAnswer = false
    @State private var gameEnded = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCounter = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isFlagTapped = false
    @State private var selectedAnswer = -1
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var QuestionView: some View {
        
        VStack (spacing: 15) {
   
            VStack {
                Text("Tap the flag of")
                    .font(.headline.weight(.bold))
                Text("\(countries[correctAnswer])")
                    .font(.largeTitle.weight(.semibold))
            
            }.foregroundColor(.secondary)

            ForEach(0..<3) { number in
                Button {
                    withAnimation(.easeIn(duration: 1.0)){
                            flagTapped(number)
                    }

                } label: {
                    FlagView(countryImage: countries[number])
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                }
                .rotation3DEffect(number == selectedAnswer ? .degrees(360) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                
                .opacity(isFlagTapped && number != selectedAnswer ? 0.5 : 1)
                .scaleEffect(isFlagTapped && number != selectedAnswer ? 0.7 : 1)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
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
                Text("Guess the flag")
                    .mainTitle()
                Spacer()
                QuestionView
                    .padding(.vertical)
                    .background(isFlagTapped
                                ? (isCorrectAnswer ? Color.green : Color.red)
                                : Color(uiColor: .systemGray5).opacity(0.65))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            }
            .padding()
        }
        .alert("Game is over.", isPresented: $gameEnded) {
            Button("Restart game", action: restartGame)
        } message: {
            Text("Your score is \(score)")
        }
    
    }
    
    

    private func flagTapped(_ number: Int) {
        selectedAnswer = number
        isFlagTapped = true
        if correctAnswer == number {
            isCorrectAnswer = true
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
        }
        delay(1, closure: askQuestion)
    }
    
    // private func to create delay for any method provided in closure
    private func delay(_ delay: Int, closure: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay), execute: closure)
    }
    
    private func askQuestion() {
        if questionCounter < 7 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionCounter += 1
        } else {
            gameEnded = true
        }
        selectedAnswer = -1
        isFlagTapped = false
        isCorrectAnswer = false
    }
    
    private func restartGame() {
        score = 0
        questionCounter = 0
        gameEnded = false
    }
    
}

struct FlagView: View {
    let countryImage: String
    
    var body: some View {
        Image(countryImage)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(color: .gray, radius: 10, x: -5, y: 5)
        
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


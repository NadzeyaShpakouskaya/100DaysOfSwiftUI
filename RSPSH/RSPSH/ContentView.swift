//
//  ContentView.swift
//  RSPSH
//
//  Created by Nadzeya Shpakouskaya on 25/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var opponentShouldWon = Bool.random()
    @State private var opponentChoice = Int.random(in: 0...2)
    @State private var score = 0
    @State private var round = 1
    @State private var gameIsOver = false
    
    let choices = ["✊", "✌️", "✋"]
    
    @ViewBuilder private var headerView: some View {
        Text("Rock, paper, scissor")
            .font(.largeTitle.bold())
    }
    
    @ViewBuilder private var opponentsView: some View  {
        
        Text(choices[opponentChoice])
            .font(.system(size: 60))
        Text("should \(opponentShouldWon ? "win" : "lose")")
            .font(.largeTitle.bold())
    }
    
    @ViewBuilder private var playerView: some View {

        HStack(spacing: 30) {
            Button {
                rockButtonTapped()
            } label: {
                Text("✊").font(.system(size: 60))
            }
            Button {
                scissorButtonTapped()
            } label: {
                Text("✌️").font(.system(size: 60))
            }
            Button {
                paperButtonTapped()
            } label: {
                Text("✋").font(.system(size: 60))
            }
        }
    }
    
    @ViewBuilder private var scoreView: some View {
        Text( "Your score is \(score)")
            .font(.largeTitle.bold())
    }
    
    var body: some View {
            ZStack {
                LinearGradient(
                    stops: [
                    .init(color:  Color("GradientColor").opacity(0.15), location: 0),
                    .init(color:  .white, location: 0.4),
                    .init(color:  .white, location: 0.6),
                    .init(color:  Color("GradientColor").opacity(0.15), location: 1)
                ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
                VStack {
                    headerView
                    Spacer()
                    opponentsView
                    Spacer()
                    Spacer()
                    playerView
                    Spacer()
                    Spacer()
                    scoreView
                }.padding()
                    .foregroundColor(Color("FontColor"))
                .alert("Game is over.", isPresented: $gameIsOver) {
                    Button("Restart game", action: restartGame)
                } message: {
                    Text("Your score is \(score)")
                }
        }
    }
    
    // increase player score
    private func increaseScore() {
        score += 1
        print("\(round) answer is correct. Your score is \(score)")
    }
    
    // decrease player score, if it's > 0
    private func decreaseScore() {
        if score > 0 {
            score -= 1
        }
        print("\(round) answer is wrong. Your score is \(score)")
    }
    
    // describe logic when rock button tapped depending on
    // opponent should win or lose
    private func rockButtonTapped() {
        if opponentChoice == 2 && opponentShouldWon {
            increaseScore()
        } else if opponentChoice == 1 && !opponentShouldWon {
            increaseScore()
        } else {
            decreaseScore()
        }
        nextRound()
    }
    
    // describe logic when scissor button tapped depending on
    // opponent should win or lose
    private func scissorButtonTapped() {
        if opponentChoice == 0 && opponentShouldWon {
            increaseScore()
        } else if opponentChoice == 2 && !opponentShouldWon {
            increaseScore()
        } else {
            decreaseScore()
        }
        nextRound()
    }
    
    // describe logic when paper button tapped depending on
    // opponent should win or lose
    private func paperButtonTapped() {
        if opponentChoice == 1 && opponentShouldWon {
            increaseScore()
        } else if opponentChoice == 0 && !opponentShouldWon {
            increaseScore()
        } else {
            decreaseScore()
        }
        nextRound()
    }
    
    // start new round in game
    private func nextRound() {
        if round < 10 {
            round += 1
            opponentChoice = Int.random(in: 0...2)
            opponentShouldWon.toggle()
        } else {
            gameIsOver.toggle()
        }

    }
    
    // restart game
    private func restartGame() {
        score = 0
        round = 0
        nextRound()
        gameIsOver = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

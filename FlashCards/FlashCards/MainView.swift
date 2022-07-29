//
//  MainView.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
    LinearGradient(
        colors: [.cyan, .green.opacity(0.35), .cyan],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    ).ignoresSafeArea()
    }
}

struct MainView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    // should timer work or not
    @State private var isActive = true
    @State private var cards = [Card]()
    @State private var showingEditScreen = false

    @EnvironmentObject var dataManager: DataManager
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {

        ZStack {
            GradientView()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(cards, id: \.id) { card in
                        if let index = cards.firstIndex(of: card) {
                            CardView(card: card) { isCorrect in
                                if isCorrect {
                                    removeCard(at: index)
                                } else {
                                    addWrongAnsweredCardBack(at: index)
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            // allow to interact only with top card
                            .allowsHitTesting(index == cards.count - 1)
                            // stop voiceOver to read all cards in a stack
                            .accessibilityHidden(index < cards.count - 1)
                        }
                    }
                }.allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start new game", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        Spacer()
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            // check if app in active mode and timer should work
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditsCardView()
        }
        .onAppear(perform: resetCards)
        .environmentObject(dataManager)
        
    }

    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    
    func addWrongAnsweredCardBack(at index: Int) {
        let newCard = Card(question: cards[index].question, answer: cards[index].answer, id: UUID())
        cards.remove(at: index)
        cards.insert(newCard, at: 0)
    }
    
    private func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        cards = dataManager.cards
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(DataManager(UserDefaultsDataManager()))
    }
}

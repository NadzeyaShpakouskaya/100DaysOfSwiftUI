//
//  EditsCard.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import SwiftUI

struct EditsCard: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Question", text: $newQuestion)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].question)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
        
        
    }
    
    func done() {
        dismiss()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func addCard() {
        let trimmedQuestion = newQuestion.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedQuestion.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(question: trimmedQuestion, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
    }
    
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
}

struct EditCard_Previews: PreviewProvider {
    static var previews: some View {
        EditsCard()
    }
}

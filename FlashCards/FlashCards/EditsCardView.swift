//
//  EditsCardView.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 27/07/2022.
//

import SwiftUI

struct EditsCardView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var newQuestion = ""
    @State private var newAnswer = ""
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack {
           
            HStack {
                Spacer()
                Text("Edit cards").font(.title)
                Spacer()
                Button(action: done) {
                    Image(systemName: "xmark")
                        .frame(width: 44, height: 44)
                        .foregroundColor(.primary)
                        .background(.clear)
                        .clipShape(Circle())
                }
           
            }
            List {
                Section("Add new card") {
                    TextField("Question", text: $newQuestion)
                    HStack{
                    TextField("Answer", text: $newAnswer)
                        Spacer()
                        Button(action: addCard) {
                            Label("Add", systemImage: "checkmark")
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .background(.green.opacity(0.35))
                                .clipShape(Capsule())
                            
                            
                        }
                        
                    }
                    
                }
                Section {
                    ForEach(dataManager.cards, id:\.id) { card in
                        VStack(alignment: .leading) {
                            Text(card.question)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards(at:))
                }
                
            }
        }.padding(.top, 16)
        .background(GradientView())
        
        
        
    }
    
    func done() {
        dismiss()
    }
    
    
    func addCard() {
        let trimmedQuestion = newQuestion.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedQuestion.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(question: trimmedQuestion, answer: trimmedAnswer)
        dataManager.addCard(card)
        newQuestion = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        dataManager.deleteCard(withID: dataManager.cards[index].id)
    }
}

struct EditCard_Previews: PreviewProvider {
    static var previews: some View {
        EditsCardView()
    }
}

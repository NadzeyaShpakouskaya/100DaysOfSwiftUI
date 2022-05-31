//
//  ContentView.swift
//  Word Scramble
//
//  Created by Nadzeya Shpakouskaya on 31/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }.navigationTitle(rootWord)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(errorMessage)
                }
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // word validation
        
        guard isOriginal(answer) else {
            wordError(title: "You've already entered it", message: "Try make new one!")
            return
        }
        
        guard isPossible(answer) else {
            wordError(title: "Word is not possible", message: "You couldn't create this word from '\(rootWord)'")
            return
        }
        
        guard isReal(answer) else {
            wordError(title: "Word not recognized", message: "You are too creative person. I don't know that word")
            return
        }
        
        
        guard answer.count > 0 else { return }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }

        
        newWord = ""
    }
    
    private func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(_ word: String) -> Bool {
        var tempRootWord = rootWord
        
        for char in word {
            // check if letter present in root word
            if let index = tempRootWord.firstIndex(of: char) {
                // remove letter from root word, user shouldn't use the same letter
                tempRootWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        // if misspelled range empty, the word exists
        return misspelledRange.location == NSNotFound
    }
    
    // update and triggered error
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func startGame() {
        // check words file exists
        if let startGameFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // check can read from file
            if let startWords = try? String(contentsOf: startGameFileURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Couldn't load words file from bundle")
        
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

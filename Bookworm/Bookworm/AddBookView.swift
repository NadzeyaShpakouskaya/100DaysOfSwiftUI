//
//  AddBookView.swift
//  Bookworm
//
//  Created by Nadzeya Shpakouskaya on 22/06/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var validToSave: Bool {
        validate(title) && validate(author) && validate(genre) && validate(review)
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Book info")
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        if validateBook() {
                        saveBook()
                        dismiss()
                        }
                    }
                }
                
            }.navigationTitle("Add book")
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMessage)
                }
        }
    }
    
    private func saveBook() {
        let book = Book(context: moc)
        book.id = UUID()
        book.date =  Date.now
        book.title = title
        book.author = author
        book.rating = Int16(rating)
        book.genre = genre
        book.review = review
        
        
        
        try? moc.save()
    }
    
    private func validate(_ data: String) -> Bool  {
        !data.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateBook() -> Bool {
        if !validate(title) {
            showAlert(title: "Title is empty", message: "Please fill the name of book")
            return false
        } else if !validate(author) {
            showAlert(title: "Author is empty", message: "Please fill the author of book")
            return false
        } else if !validate(genre) {
            showAlert(title: "Select genre", message: "Please select the genre of book")
            return false
        } else  if !validate(review) {
            showAlert(title: "Review is empty", message: "Please provide some words about the book")
            return false
        }
        return true
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

//
//  MainView.swift
//  Bookworm
//
//  Created by Nadzeya Shpakouskaya on 22/06/2022.
//

import SwiftUI

struct MainView: View {
    // call managedObjectContext that we create on the running our app
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.rating, order: .reverse),
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(books) { book in
                    NavigationLink {
                       DetailView(book: book)
                    } label: {
                        HStack(spacing: 10) {
                            EmojiRatingView(rating: book.rating)
                                .font(.title)
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown title")
                                    .font(.headline)
                                Text(book.author ?? "n/a")
                                    .font(.subheadline.italic())
                            }
                        }
                    }

                }.onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    private func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

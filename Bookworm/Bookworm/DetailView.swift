//
//  DetailView.swift
//  Bookworm
//
//  Created by Nadzeya Shpakouskaya on 23/06/2022.
//
import CoreData
import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
 

            Text(book.review ?? "No review")
                .padding()
            // we use constant as we want just displaying rating without changing
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            Text(formattedDate(book.date))
                .bold()
                .padding()
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete this book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Book will be deleted from your list.\nAre you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete book", systemImage: "trash")
                    .foregroundColor(.red)
            }

        }
    }
    
    private func deleteBook() {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
    
    private func formattedDate(_ date: Date?) -> String {
        if let date = date {
            return "Reviewed: \(date.formatted(date: .abbreviated, time: .omitted))"
        }
        return "Reviewed: n/a"
    }
    
}
// we can't use preview with CoreData easily, so just disable preview
//struct DetailView_Previews: PreviewProvider {
//
//    static var previews: some View {
//       DetailView()
//    }
//}

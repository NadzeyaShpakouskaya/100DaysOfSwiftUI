//
//  ContentView.swift
//  CD_Project
//
//  Created by Nadzeya Shpakouskaya on 24/06/2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var containsCharacters = "swift"
    
    
    var body: some View {
        VStack {
            // we should specify our NSObject like (item:Type) to work with item's parameters
            Text("Course initializer")
            FilteredList(filteringKey: "lastname", filteringValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Text("Challenge initializer")
            FilteredList(
                filteringKey: "lastname",
                filteringValue: containsCharacters,
                filterUsing: .containsInsensitive,
                sortDescriptors: [SortDescriptor<Singer>(\.firstName)]
            ) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastname = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastname = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastname = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }.padding(.vertical, 20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

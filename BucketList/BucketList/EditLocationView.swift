//
//  EditLocationView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import SwiftUI

struct EditLocationView: View {
    @Environment(\.dismiss) var dismiss
    var location: Location
    // we use closure to pass back edit Location from view to parent view
    var onSave:(Location) -> Void
    
    @State private var title: String
    @State private var description: String
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $title)
                    TextField("Description", text: $description)
                }
            }
            .navigationTitle("Place details")
            .toolbar {
   
                Button("Save") {
                    var newInfo = location
                    newInfo.id = UUID()
                    newInfo.title = title
                    newInfo.description = description
                    onSave(newInfo)
                    
                    dismiss()
                }
            }
        }
    }
    
    // create custom init to wrap our State title and description with passed location
    // we use closure to pass back edit Location from view to parent view
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _title = State(initialValue: location.title)
        _description = State(initialValue: location.description)
    }
}

struct EditLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EditLocationView(location: Location.testLocation) {_ in }
    }
}

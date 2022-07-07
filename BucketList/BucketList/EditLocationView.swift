//
//  EditLocationView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import SwiftUI

struct EditLocationView: View {

    @Environment(\.dismiss) var dismiss
    // we use closure to pass back edit Location from view to parent view
    var onSave:(Location) -> Void
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Place name", text: $viewModel.title)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Something interesting nearby...") {
                    switch viewModel.loadingStatus {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(":\n")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Oops, there are no interesting places nearby or I couldn't find them.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
   
                Button("Save") {
                    onSave(viewModel.updateLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces(location: viewModel.location)
            }
        }
    }
    
    // create custom init to wrap our ViewModel with passed location
    // we use closure to pass back edited Location to parent view
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
    }
}

struct EditLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EditLocationView(location: Location.testLocation) {_ in }
    }
}

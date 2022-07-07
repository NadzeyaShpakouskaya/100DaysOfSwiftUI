//
//  EditLocationView.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 05/07/2022.
//

import SwiftUI

struct EditLocationView: View {
    enum LoadingStatus {
        case loading, loaded, failed
    }
    @Environment(\.dismiss) var dismiss
    var location: Location
    // we use closure to pass back edit Location from view to parent view
    var onSave:(Location) -> Void
    
    @State private var title: String
    @State private var description: String
    
    @State private var loadingStatus = LoadingStatus.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $title)
                    TextField("Description", text: $description)
                }
                
                Section("Something interesting nearby...") {
                    switch loadingStatus {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        ForEach(pages, id: \.pageid) { page in
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
                    var newInfo = location
                    newInfo.id = UUID()
                    newInfo.title = title
                    newInfo.description = description
                    onSave(newInfo)
                    
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    // create custom init to wrap our State title and description with passed location
    // we use closure to pass back edited Location to parent view
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _title = State(initialValue: location.title)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Error: bad url for \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingStatus = .loaded
        } catch {
            loadingStatus = .failed
        }
    }
}

struct EditLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EditLocationView(location: Location.testLocation) {_ in }
    }
}

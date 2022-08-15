//
//  MainView.swift
//  SnowSeeker
//
//  Created by Nadzeya Shpakouskaya on 13/08/2022.
//

import SwiftUI

struct MainView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    enum SortedOrder {
        case name, country, standart
    }

    var sortedResorts: [Resort] {
        switch sortedOder {
        case .name: return resorts.sorted { $1.name > $0.name }
        case .country: return resorts.sorted { $1.country > $0.country }
        case .standart: return resorts
        }
    }
    
    
    @State private var sortedOder = SortedOrder.standart
    @State private var showingSorting = false
    @State private var searchText = ""
    @StateObject var favorites = Favorites()
    
    var body: some View {
        NavigationView{
            // List with navigation title is primary view
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        )
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibilityLabel("This is a favorite resort")
                        .foregroundColor(.red)
                    }
                    }
                }
                
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .navigationTitle("Resorts")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: favorites.loadData)
            .toolbar {
                Button {
                    showingSorting.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                }
            }
            .confirmationDialog("Sorting order", isPresented: $showingSorting) {
                Button("Default") {
                    sortedOder = .standart
                }
                
                Button("Resort Name") {
                    sortedOder = .name
                }
                
                Button("Country") {
                    sortedOder = .country
                }

            }
            
            // this is the secondary view that will be presented for big screens in landscape view
            WelcomeView()
        }
        // we use modifier to display only primary view for big screen of iphones
        .phoneOnlyStackNavigationView()
        .environmentObject(favorites)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

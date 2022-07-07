//
//  EfitLocationViewVM.swift
//  BucketList
//
//  Created by Nadzeya Shpakouskaya on 07/07/2022.
//

import Foundation
import SwiftUI

extension EditLocationView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingStatus {
            case loading, loaded, failed
        }
        
        var location: Location
        
        @Published var title: String
        @Published var description: String
        
        @Published var loadingStatus = LoadingStatus.loading
        @Published var pages = [Page]()
        
        init(location: Location) {
          title = location.title
          description = location.description
          self.location = location
        }
        
        func fetchNearbyPlaces(location: Location) async {
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
        
        
        /// return updated Info
        func updateLocation() -> Location {
            var newInfo = location
            newInfo.id = UUID()
            newInfo.title = title
            newInfo.description = description
            return newInfo
        }
        
    }
}

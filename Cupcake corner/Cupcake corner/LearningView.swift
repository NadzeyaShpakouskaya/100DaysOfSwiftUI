//
//  LearningView.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

struct LearningView: View {
    @State private var tracks = [Result]()
    
    var body: some View {
        
        VStack {

            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Oops... Something went wrong")
                        .font(.headline)
                } else {
                    ProgressView()
                }
            }.frame(width: 150, height: 150)
            
            
            List(tracks, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }.task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let responseData = try? JSONDecoder().decode(Response.self, from: data) {
                tracks = responseData.results
            }
        } catch {
            print("Data fetch error")
        }
    }
}


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}

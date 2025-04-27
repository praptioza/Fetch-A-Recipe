//
//  RecipeDetailsView.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/23/25.
//

import SwiftUI

struct RecipeDetailsView : View {
    let recipe: Recipe                       // populates each recipe details
    
    var body : some View{
        ScrollView {
            VStack{
                // // optional binding, checks if recipe has a small photo and gets its url
                if let photo_url_small = recipe.photo_url_large?.absoluteString {
                    // if url exists, ImagesView gets rendered and image is loaded asynchronously and shown to view what gets returned
                    ImagesView(
                        urlString: photo_url_small,
                        errorImage: Image(systemName: "xmark.octagon")
                    )
                    .frame(width: 350, height: 350)
                    .clipped()
                    .cornerRadius(15)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                }

                
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.headline).padding(.bottom, 10)
                
                if let sourceURL = recipe.source_url {
                    Link("Read Full Recipe", destination: sourceURL).font(.headline).foregroundColor(.blue).padding(.bottom, 10)
                }
                
                if let youtubeURL = recipe.youtube_url {
                    Link("Watch YouTube Video", destination: youtubeURL).font(.headline).foregroundColor(.blue).padding(.bottom, 10)
                }
            }//end of VStack
            .padding()
        }//end of ScrollView
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(recipe: Recipe(
            id: UUID(),
            cuisine: "British",
            name: "Sample Recipe",
            photo_url_large: URL(string: "https://example.com/large.jpg")!,
            photo_url_small: URL(string: "https://example.com/small.jpg")!,
            source_url: URL(string: "https://example.com")!,
            youtube_url: URL(string: "https://youtube.com")!
        ))
    }
}

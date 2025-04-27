//
//  RecipeRowView.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/23/25.

//


import SwiftUI

struct RecipeRowView : View {

    let recipe : Recipe                    // populates each row details
    
    var body : some View {

        HStack(spacing: 10) {
            // optional binding, checks if recipe has a small photo and gets its url
            if let photo_url_small = recipe.photo_url_small?.absoluteString {
                // if url exists, ImagesView gets rendered and image is loaded asynchronously and shown to view what gets returned
                ImagesView(
                    urlString: photo_url_small,
                    errorImage: Image(systemName: "xmark.octagon")
                )
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack (alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.headline)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        } // end of HSTACK
        .padding(.vertical, 4)

    }
}

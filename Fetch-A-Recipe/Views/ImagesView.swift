//
//  ImagesView.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/24/25.
//
import Foundation
import SwiftUI

struct ImagesView: View {
    
    @StateObject private var loader = ImageLoaderService()
    @State private var isLoading: Bool = true                  // check if image is being fetched (loading)
    let urlString: String
    let errorImage: Image

    var body: some View {
        ZStack {
            // if image loaded then set it as SwiftUI Image
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }
            // if image is not loaded but it is still loading (isLoading = true) it is donw when asychronously image is being fetched
            else if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            // if image is not returned after async fetching, isLoading is false and error image is rendered
            else {
                errorImage
                    .resizable()
                    .scaledToFit()
            }
        } // end of ZStack
        // when view loads, async image loading starts, bool is set to true and so progress image is shown, once the image is loaded , it gets rendered on view, else nil turns to error symbol
        .onAppear {
            Task {
                isLoading = true
                loader.loadImage(from: urlString)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isLoading = loader.image == nil
                }
            } // end of Task
        }
    } //end of body
}

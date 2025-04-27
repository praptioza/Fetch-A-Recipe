//
//  RecipesListView.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/22/25.
//

import Foundation
import SwiftUI

struct RecipesListView : View {
    @StateObject private var viewModel = RecipesViewModel()
    
    var body : some View {
        NavigationView {
            // group of different views that change according to the data that is fetched and being displayed
            Group {
                // if the data is malformed
                if let error = viewModel.errormessage {
                    VStack(alignment: .center) {
                        Text(error)
                            .font(.body)
                            .foregroundColor(.red)
                            .padding()
                    } // end of VStack for malformed data view
                } // end of malformed data's conditional error
                
                else if viewModel.isEmpty{
                    VStack(alignment: .center){
                        Text("No recipes available!")
                            .font(.body)
                            .foregroundColor(.red)
                            .padding()
                        //                        Spacer()
                    } // end of VStack for empty data view
                } // end of empty data's conditional error
                
                else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailsView(recipe:recipe)){
                            RecipeRowView(recipe:recipe)
                        }
                    } .refreshable {
                        await viewModel.fetchAllRecipes()
                    }
                } // end of recipes data conditional
            } // end of Group
            .navigationTitle("Fetch-A-Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            await viewModel.fetchAllRecipes()
                        }
                    }) {
                        
                        Image(systemName: "arrow.clockwise")
                    }.accessibilityIdentifier("refreshButton")
                }
            } // end of toolbar
            .task{
                await viewModel.fetchAllRecipes()
            }
        } // end of NavigationView
    }
}

struct RecipesList_Previews: PreviewProvider {
    static var previews: some View {
        RecipesListView()
    }
}


//
//  RecipesViewModel.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/22/25.
//
import Foundation


@MainActor

final class RecipesViewModel : ObservableObject {
    @Published var recipes : [Recipe] = []                     //holds list of fetched recipes and refreshes views everytime it changes/refetched
    @Published var errormessage : String? = nil                //holds API or decoding error messages when encountered during API data fetch
    @Published var isEmpty : Bool = false                      //flag to show emoty state that is no data fetched
    
    private let service : RecipeFetchService
    
    init(service: RecipeFetchService = RecipeFetchService()){
        self.service = service
    }
    
    func fetchAllRecipes() async {
        do{
            let fetchedRecipes = try await service.fetchRecipes()
            if fetchedRecipes.isEmpty {
                isEmpty = true
                errormessage = nil
            }
            else {
                recipes = fetchedRecipes
                isEmpty = false
                errormessage = nil
            }
        }
        catch{
            errormessage = "Failed to load recipes. Please try again later!"
            recipes = []
            isEmpty = false
            print("No recipes fetched")
        }
    } //end of fetchRecipes()
    
} // end of class

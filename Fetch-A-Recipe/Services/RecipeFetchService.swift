//
//  RecipeFetchService.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/22/25.
//


import Foundation

// Service to fetch recipe data from API (JSON data) asynchronously

actor RecipeFetchService{
    //the base url of the recipe API to be used to fetch data
//    let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    
    private let baseURL: URL

    // Custom initializer
    init(baseURL: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!) {
        self.baseURL = baseURL
    }
    
    
    // function to fetch the recipes asynchronously	
    // async used to fetch data asynchronously and
    func fetchRecipes() async throws -> [Recipe] {
        //asynchronous network request and await network reponse
        let (data, response) = try await URLSession.shared.data(from: baseURL)
        // validate the HTTP Response
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        // decode the JSON data to model representation and return the recipes array
        return try JSONDecoder().decode(RecipesResponse.self, from: data).recipes
    }
}

//
//  Recipe.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/22/25.
//

// Models are struct that represents the data that the app needs to work with, ir provides raw, structured data to be processed and rendered to the UI


import Foundation

/*
 JSON Structure
 "recipes": [
     {
         "cuisine": "British",
         "name": "Bakewell Tart",
         "photo_url_large": "https://some.url/large.jpg",
         "photo_url_small": "https://some.url/small.jpg",
         "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
         "source_url": "https://some.url/index.html",
         "youtube_url": "https://www.youtube.com/watch?v=some.id"
     },
     ...
 ]
}
*/

// main list of recipes from the JSON API response
struct RecipesResponse : Codable {
    let recipes : [Recipe]
}

// individual model structure for each recipe from the main response list
struct Recipe : Codable, Identifiable {
    let id : UUID
    let cuisine : String
    let name : String
    let photo_url_large : URL?
    let photo_url_small : URL?
    let source_url : URL?
    let youtube_url : URL?
    
    enum CodingKeys : String, CodingKey {
        case id = "uuid"
        case cuisine;
        case name
        case photo_url_large
        case photo_url_small
        case source_url
        case youtube_url
    }
}
	

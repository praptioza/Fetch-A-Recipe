//
//  RecipeFetchServiceTests.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/25/25.
//

import XCTest
@testable import Fetch_A_Recipe

// Test class for RecipeFetchService to test API fetching behavior
final class RecipeFetchServiceTests : XCTestCase {
    
    
    // Test case for successfully fetching recipes from the normal endpoint
    func testFetchRecipes_SuccessResponse() async throws {
        if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"){
            let service = RecipeFetchService(baseURL: url)
            let recipes = try await service.fetchRecipes()
            // assert that the recipes array is not empty
            XCTAssertFalse(recipes.isEmpty, "Recipes should not be empty on successful fetch.")
        } else {
            XCTFail("URL was invalid")
        }
    } // end of successful fetch test
    
    
    
    // Test class for fetching recipes when API returns empty list
    func testFetchRecipes_EmptyResponse() async throws {
        if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json") {
            let service = RecipeFetchService(baseURL: url)
            let recipes = try await service.fetchRecipes()
            // Assert that the recipes array is empty
            XCTAssertTrue(recipes.isEmpty, "Recipes should be empty when API fetches no data.")
        } else {
            XCTFail("URL was invalid")
        }
    } // end of empty fetch test
    
    
    
    
    // Test case for handling a malformed API response
    func testFetchRecipes_MalformedRepsonse_DecodingError() async throws {
        if let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json") {
            let service = RecipeFetchService(baseURL : url)
            
            do {
                _ = try await service.fetchRecipes()
                
                XCTFail("Should fail but succeeded")
            }
            catch {
                // Assert that the thrown error is a DecodingError
                XCTAssertTrue(error is DecodingError, "Expected to be decoding error but is \(error)")
            }
        } else {
            XCTFail("URL WAS invalid")
        }
    } // end of malformed error test
    
}

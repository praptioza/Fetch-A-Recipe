//
//  RecipesViewModelTests.swift
//  Fetch-A-Recipe
//
//  Created by user274833 on 4/25/25.
//

import XCTest

@testable import Fetch_A_Recipe

@MainActor

// Test class for RecipeViewModel
final class RecipesViewModelTests : XCTestCase {
    
    var viewModel : RecipesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RecipesViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // Test to check successful fetching of all recipes
    func testFetchAllRecipes_Success() async {
        await viewModel.fetchAllRecipes()
        
        // assert that the recipes array if fetched
        XCTAssertFalse(viewModel.recipes.isEmpty, "Recipes array should not be empty after successful fetch.")
        // assert that no error is there
        XCTAssertNil(viewModel.errormessage, "Error message should be nil on successful fetch.")
        // assert that isEmpty is set to false
        XCTAssertFalse(viewModel.isEmpty, "isEmpty should be false when recipes exist and are successfully fetched.")
    }// end of success test
    
    
    // Test to check error handling when fetching all recipes fails
    func testDetchAllRecipes_WhenError_SetErrorMessage() async {
        //simultaing failure by providing a wrong URL
        let wrongService = RecipeFetchService(baseURL: URL(string: "https://invalid-url.com")!)
        let wrongViewModel = RecipesViewModel(service: wrongService)
        // attempt to fetch recipes which should fail
        await wrongViewModel.fetchAllRecipes()
        
        // assert that error message is shown and that recipe array remains empty after failure
        XCTAssertEqual(wrongViewModel.errormessage, "Failed to load recipes. Please try again later!")
        XCTAssertTrue(wrongViewModel.recipes.isEmpty)
    }
}

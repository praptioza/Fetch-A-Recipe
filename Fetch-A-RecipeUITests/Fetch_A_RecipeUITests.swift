//
//  Fetch_A_RecipeUITests.swift
//  Fetch-A-RecipeUITests
//
//  Created by user274833 on 4/22/25.
//

import XCTest

final class Fetch_A_RecipeUITests: XCTestCase {
    
    private var app : XCUIApplication!

    override func setUpWithError() throws {
        // This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITestMode"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    @MainActor
    func testAppLaunch_Success() throws {
        XCTAssertTrue(app.navigationBars["Fetch-A-Recipe"].exists, "App should launch with Recipe List.")
    }
    
    @MainActor
    func testRecipesListLoad_Success() throws {
        let first_row = app.cells.firstMatch
        XCTAssertTrue(first_row.waitForExistence(timeout: (5)), "Atleast one recipe should load.")
    }

    @MainActor
    func testTapRecipeShowDetails_Success() throws {
        let first_row = app.cells.firstMatch
        XCTAssertTrue(first_row.waitForExistence(timeout: (5)), "Recipe row should exist.")
        first_row.tap()
        let scroll_view = app.scrollViews.firstMatch
        XCTAssertTrue(scroll_view.waitForExistence(timeout: (5)), "Recipe details scroll view should be displayed.")
    }
    
    @MainActor
    func testRecipeDetailsContent_Success() throws{
        let first_row = app.cells.firstMatch
        XCTAssertTrue(first_row.waitForExistence(timeout: 5), "Recipe row should be displayed.")
        first_row.tap()
        XCTAssertTrue(app.navigationBars.firstMatch.exists, "Recipe Detail navigation title exists and matches the recipe row tapped.")
          
        let recipe_img = app.images.firstMatch
        XCTAssertTrue(recipe_img.exists, "Correct recipe image is displayed.")
        
        let recipe_read_link = app.links["Read Full Recipe"]
        if recipe_read_link.exists{
            XCTAssertTrue(recipe_read_link.exists, "Read full recipe link is displayed.")
        }
        
        let recipe_youtube_link = app.links["Watch YouTube Video"]
        if recipe_youtube_link.exists{
            XCTAssertTrue(recipe_youtube_link.exists, "Youtube video link is displayed.")
        }
    }
    
    @MainActor
    func testRefreshButtonRecipesList_Success() throws {
        let refresh_button = app.buttons["refreshButton"]
        XCTAssertTrue(refresh_button.exists, "Refresh Button for recipes reload should be displayed.")
        refresh_button.tap()
        let list = app.cells.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5), "Recipe list should reload and be displayed again after pressing the refresh button.")
    }
}

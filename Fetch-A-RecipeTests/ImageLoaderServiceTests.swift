////
////  ImageLoaderServiceTests.swift
////  Fetch-A-Recipe
////
////  Created by user274833 on 4/25/25.
////
//
import XCTest

@testable import Fetch_A_Recipe

@MainActor

// Test class for ImageLoaderService
final class ImageLoaderServiceTests : XCTestCase {
    
    var loader : ImageLoaderService!
    
    override func setUp() {
        super.setUp()
        loader = ImageLoaderService()
    }
    
    override func tearDown() {
        loader = nil
        super.tearDown()
    }
    
    // testing image loading from memory cache
    func testLoadImage_FromMemCache() {
        let testUrl = "http://example.com/test.jpg"
        let testImg = UIImage(systemName: "photo")!
        
        // manually test the image in cache
        ImageLoaderService.cachememory.setObject(testImg, forKey: NSString(string: testUrl))
        loader.loadImage(from: testUrl)
        
        // asset that loaded image is what was in the cache
        XCTAssertEqual(loader.image, testImg, "Image should be loaded from memory cache")
    } // end
    
    
    // test error for invalid url call
    func testLoadImage_NetworkError() async {
        let invalidURL = "invalid_url"
        
        loader.loadImage(from: invalidURL)
        
        XCTAssertNil(loader.image, "Image should be nil when loading from invalid url")
    }
}

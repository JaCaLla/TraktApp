//
//  UN_Movie.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import XCTest

@testable import TraktApp

class UN_MovieSet: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_initPopular(){
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(MovieSet(arrPopular: []),"Validate that arrays are not allowed as initializers")
        
        XCTAssertNil(MovieSet(arrPopular: [:]),"Validate that empty dictionaries are not allowed")
        
        let dicMissingTitle:[String:Any] = [
            "titleX":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        let dicValidMovie:[String:Any] = [
            "title":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        let arrValidsMovies = [dicValidMovie,dicValidMovie]
        if let movieSet = MovieSet(arrPopular: arrValidsMovies) {
            XCTAssertEqual(movieSet.movies.count, 2)
        }else{
            XCTFail()
        }
        
        let arrWithOneInvalid = [dicValidMovie,dicValidMovie,dicMissingTitle,dicValidMovie]
        if let movieSet = MovieSet(arrPopular: arrWithOneInvalid) {
            XCTAssertEqual(movieSet.movies.count, 3)
        }else{
            XCTFail()
        }
    }
    
    func test_initSearch(){
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(MovieSet(arrPopular: []),"Validate that arrays are not allowed as initializers")
        
        XCTAssertNil(MovieSet(arrPopular: [:]),"Validate that empty dictionaries are not allowed")
        
        let dicMissingTitle:[String:Any] = [
            "titleX":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        let dicValidMovie:[String:Any] = [
            "title":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        let dicValidSearch:[String:Any]=[
            "movie":dicValidMovie
        ]
        
        let dicInvalidSearch:[String:Any]=[
            "movie":dicMissingTitle
        ]
        
        let arrValidsMovies = [dicValidSearch,dicValidSearch]
        if let movieSet = MovieSet(arrSearch: arrValidsMovies) {
            XCTAssertEqual(movieSet.movies.count, 2)
        }else{
            XCTFail()
        }
        
        let arrWithOneInvalid = [dicValidSearch,dicValidSearch,dicInvalidSearch,dicValidSearch]
        if let movieSet = MovieSet(arrSearch: arrWithOneInvalid) {
            XCTAssertEqual(movieSet.movies.count, 3)
        }else{
            XCTFail()
        }
    }
    
}

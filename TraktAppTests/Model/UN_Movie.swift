//
//  UN_Movie.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import XCTest

@testable import TraktApp

class UN_Movie: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_initDicMovie(){
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNil(Movie(dicMovie: []),"Validate that arrays are not allowed as initializers")
        
        XCTAssertNil(Movie(dicMovie: [:]),"Validate that empty dictionaries are not allowed")
        
        let dicMissingTitle:[String:Any] = [
            "titleX":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        XCTAssertNil(Movie(dicMovie: dicMissingTitle),"Validate dictionary with wrong key title")
        
       
        
        let dicMissingIds:[String:Any] = [
            "title":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "idsX": ["imdb": "tt0372784"]
        ]
        XCTAssertNil(Movie(dicMovie: dicMissingIds),"Validate dictionary with wrong key ids")

        let dicValidMovie:[String:Any] = [
            "title":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        if let movie = Movie(dicMovie: dicValidMovie) {
            XCTAssertEqual(movie.title, "movie title")
            XCTAssertTrue(movie.year == 2005)
            XCTAssertEqual(movie.overview, "overview text")
        }else{
            XCTFail()
        }
    }
    
    func test_initDicSearch(){
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNil(Movie(dicSearch: []),"Validate that arrays are not allowed as initializers")
        
        XCTAssertNil(Movie(dicSearch: [:]),"Validate that empty dictionaries are not allowed")
        

        
        let dicValidMovie:[String:Any] = [
            "title":"movie title" ,
            "year": 2005 ,
            "overview" : "overview text",
            "ids": ["imdb": "tt0372784"]
        ]
        
        
        let dicValidSearch:[String:Any]=[
            "movie":dicValidMovie
        ]
        
        if let movie = Movie(dicSearch: dicValidSearch) {
            XCTAssertEqual(movie.title, "movie title")
            XCTAssertTrue(movie.year == 2005)
            XCTAssertEqual(movie.overview, "overview text")
        }else{
            XCTFail()
        }
    }

}

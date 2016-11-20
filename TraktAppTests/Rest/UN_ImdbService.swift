//
//  UN_TraktService.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import XCTest

@testable import TraktApp

class UN_ImdbService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_baseURL(){
        XCTAssertEqual(ImdbService.sharedInstance.baseURL, "http://www.omdbapi.com/")
    }
    
    func test_fetchImageURL() {
        // Good case
        let asyncExpectation = expectation(description: "Good case")
        ImdbService.sharedInstance.fetchImageURL(imdbId: "tt3659388",
                                                 success: {
                                                    url in
                                                    
                                                    XCTAssertEqual("\(url)", "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc2MTQ3MDA1Nl5BMl5BanBnXkFtZTgwODA3OTI4NjE@._V1_SX300.jpg")
                                                    
                                                    asyncExpectation.fulfill()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
    }

    func test_WrongImdbId() {
        // Good case
        let asyncExpectation = expectation(description: "Good case")
        ImdbService.sharedInstance.fetchImageURL(imdbId: "WrongId",
        success: {_ in
            XCTFail()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            asyncExpectation.fulfill()
        }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    
    
}

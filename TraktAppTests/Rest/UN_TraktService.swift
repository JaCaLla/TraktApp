//
//  UN_TraktService.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import XCTest

@testable import TraktApp

class UN_TraktService: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_baseURL(){
        XCTAssertEqual(TraktService.sharedInstance.baseURL, "https://api.trakt.tv/")
    }
    
    func test_popular() {
        // Good case
        let asyncExpectation = expectation(description: "Good case")
        TraktService.sharedInstance.popular(page:1,
                                            limit:10,
                                           success: {
                                            moviesSet in

                                            XCTAssertTrue(moviesSet.movies.count==10)
                                            
                                            asyncExpectation.fulfill()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    
    func test_search() {
        
    
        // Good case
        let asyncExpectation = expectation(description: "Good case")
        TraktService.sharedInstance.search(query:"terminator",
                                           page:1,
                                            limit:10,
                                            success: {
                                                moviesSet in
                                                
                                                XCTAssertTrue(moviesSet.movies.count==10)
                                                
                                                asyncExpectation.fulfill()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
    }
    
}

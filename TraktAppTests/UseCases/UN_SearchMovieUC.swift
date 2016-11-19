//
//  UN_SearchMovieUC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import XCTest

@testable import TraktApp

class UN_SearchMovieUC: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_search() {
        
        
        let asyncExpectation = expectation(description: "Good case")
        
        SearchMovieUC.sharedInstance.first(query:"terminator",
                                           success: {
                                            moviesSet in
                                            
                                            XCTAssertTrue(moviesSet.movies.count==100)
                                            
                                            asyncExpectation.fulfill()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        self.waitForExpectations(timeout: 3, handler: nil)
        
        
    }
    
    
    func test_search2ConsecutiveTimes() {
        

        let asyncExpectation = expectation(description: "Good case")
        
        SearchMovieUC.sharedInstance.first(query:"terminator",
                                           success: {
                                            moviesSet in
                    
                                           XCTAssertTrue(moviesSet.movies.count==0)
                                          //  print("1st call:\(moviesSet.movies.count)")
                                            
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        
        sleep(UInt32(1))
        
        SearchMovieUC.sharedInstance.first(query:"tron",
                                           success: {
                                            moviesSet in
                                            
                                            XCTAssertTrue(moviesSet.movies.count==19)
                                            //print("2nd call:\(moviesSet.movies.count)")
                                            asyncExpectation.fulfill()
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )
        
        self.waitForExpectations(timeout: 90, handler: nil)
   
        
    }
    
    
    func test_searchFirstAndNext() {
        
        
        let asyncExpectation = expectation(description: "Good case")
        
        SearchMovieUC.sharedInstance.first(query:"supe",
                                           success: {
                                            moviesSet in
                                            
                                            XCTAssertTrue(moviesSet.movies.count==2)
                                            //  print("1st call:\(moviesSet.movies.count)")
                                            
                                            SearchMovieUC.sharedInstance.next(query:"supe",
                                                                              success: {
                                                                                moviesSet in
                                                                                
                                                                                XCTAssertTrue(moviesSet.movies.count==0)
                                                                                //print("2nd call:\(moviesSet.movies.count)")
                                                                                asyncExpectation.fulfill()
                                            },serverFailure: { (error) in
                                                XCTFail()
                                            },businessFailure: { (error) in
                                                XCTFail()
                                            }
                                            )
                                            
        },serverFailure: { (error) in
            XCTFail()
        },businessFailure: { (error) in
            XCTFail()
        }
        )

        

        
        self.waitForExpectations(timeout: 90, handler: nil)
        
        
    }
}

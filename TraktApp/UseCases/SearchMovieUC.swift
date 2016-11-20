//
//  MostPupularUC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import Foundation


class SearchMovieUC {
    static let sharedInstance = SearchMovieUC()
    
    var page:Int = 1
    let limit:Int = 100
    var ongoingRequest:Int = 0
    
    private init() {}
    
    func first(query:String,
               success succeed : @escaping ((MovieSet) -> ()),
               serverFailure serverFail : @escaping ((NSError) -> ()),
               businessFailure businessFail : @escaping ((NSError) -> ())){
        
        self.page = 1
        
        self.ongoingRequest += 1
        
        TraktService.sharedInstance.search(query: query, page: self.page, limit: self.limit, success: {[unowned self] movieSet in
            self.ongoingRequest -= 1
            
           if(self.ongoingRequest==0){
                succeed(movieSet)
            }else{
                succeed(MovieSet(arrSearch:[])!)
            }
                
        }, serverFailure: serverFail, businessFailure: businessFail)
    }
    
    func next(query:String,
              success succeed : @escaping ((MovieSet) -> ()),
               serverFailure serverFail : @escaping ((NSError) -> ()),
               businessFailure businessFail : @escaping ((NSError) -> ())){
        
        if(self.page<limit){
            self.page += 1
        }else{
            return succeed(MovieSet(arrSearch:[])!)
        }
        
        TraktService.sharedInstance.search(query:query,
                                           page:self.page,
                                           limit:self.limit,
                                           success:succeed,
                                           serverFailure:serverFail,
                                           businessFailure:serverFail)
    }
    
}

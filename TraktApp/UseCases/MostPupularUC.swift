//
//  MostPupularUC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import Foundation


class MostPopularUC {
    static let sharedInstance = MostPopularUC()
    
    var page:Int = 0
    let limit:Int = 100
    
    private init() {}
    
    func first(success succeed : @escaping ((MovieSet) -> ()),
               serverFailure serverFail : @escaping ((NSError) -> ()),
               businessFailure businessFail : @escaping ((NSError) -> ())){
        
        self.page = 0
        
        TraktService.sharedInstance.popular(page:self.page,
                                            limit:self.limit,
                                            success:succeed,
                                            serverFailure:serverFail,
                                            businessFailure:serverFail)
    }
    
    func next(success succeed : @escaping ((MovieSet) -> ()),
               serverFailure serverFail : @escaping ((NSError) -> ()),
               businessFailure businessFail : @escaping ((NSError) -> ())){
        
        if(self.page<limit){
            self.page += 1
        }else{
            return succeed(MovieSet(arrSearch:[])!)
        }
        
        TraktService.sharedInstance.popular(page:self.page,
                                            limit:self.limit,
                                            success:succeed,
                                            serverFailure:serverFail,
                                            businessFailure:serverFail)
    }
    
}

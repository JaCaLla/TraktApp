//
//  TraktService.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//


import Foundation
import Alamofire

class TraktService {
    static let sharedInstance = TraktService()
    
    var baseURL:String = "https://api.trakt.tv/"
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/json",
        "trakt-api-version": "2",
        "trakt-api-key":"019a13b1881ae971f91295efc7fdecfa48b32c2a69fe6dd03180ff59289452b8"
    ]
    
    
    private init() {}
    
    func popular(page:Int,
                 limit:Int,
                 success succeed : @escaping ((MovieSet) -> ()),
                 serverFailure serverFail : @escaping ((NSError) -> ()),
                 businessFailure businessFail : @escaping ((NSError) -> ())){
        
        let parameters: Parameters = ["page": String(page),
                                      "limit": String(limit),
                                      "extended":"full"]
        
        Alamofire.request(self.baseURL + "movies/popular",  parameters:parameters,headers:self.headers).validate(statusCode: 200..<401).responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let resultValue = response.result.value,
                    let movieSet:MovieSet = MovieSet(arrPopular: resultValue){
                    succeed(movieSet)
                }else{
                    businessFail(NSError())
                }
                
            case .failure(let error):
                serverFail(error as NSError)
            }
        }
    }
    
    func search(query:String,
                page:Int,
                 limit:Int,
                 success succeed : @escaping ((MovieSet) -> ()),
                 serverFailure serverFail : @escaping ((NSError) -> ()),
                 businessFailure businessFail : @escaping ((NSError) -> ())){
        
        let parameters: Parameters = ["query":query,
                                      "page": String(page),
                                      "limit": String(limit),
                                      "extended":"full"]
        
        Alamofire.request(self.baseURL + "search/movie",  parameters:parameters,headers:self.headers).validate(statusCode: 200..<401).responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let resultValue = response.result.value,
                    let movieSet:MovieSet = MovieSet(arrSearch: resultValue){
                    succeed(movieSet)
                }else{
                    businessFail(NSError())
                }
                
            case .failure(let error):
                serverFail(error as NSError)
            }
        }
    }
    
}


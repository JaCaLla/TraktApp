//
//  TraktService.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//


import Foundation
import Alamofire

class ImdbService {
    static let sharedInstance = ImdbService()
    
    var baseURL:String = "http://www.omdbapi.com/"
    
    let headers: HTTPHeaders = [:]
    
    
    private init() {}
    
    func fetchImageURL(imdbId:String,
                       success succeed : @escaping ((URL) -> ()),
                       serverFailure serverFail : @escaping ((NSError) -> ()),
                       businessFailure businessFail : @escaping ((NSError) -> ())){
        
        let parameters: Parameters = ["i": imdbId,
                                      "plot": "short",
                                      "r":"json"]
        
        Alamofire.request(self.baseURL,  parameters:parameters,headers:self.headers).validate(statusCode: 200..<401).responseJSON { response in
            
            switch response.result {
            case .success:
                
                if let dicJSON:[String:Any]  = response.result.value as! [String : Any]?,
                    let urlStr:String = dicJSON["Poster"] as! String?,
                    let url = URL(string:urlStr){
                    succeed(url)
                }else{
                    businessFail(NSError())
                }
                
            case .failure(let error):
                serverFail(error as NSError)
            }
        }
    }
    
    
}


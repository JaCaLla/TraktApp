//
//  Movie.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import Foundation

struct Movie {
    let title : String
    let year : Int?
    var overview: String?
    var imdb : String?
    var  pictureURL: URL?
    
    
    init?(dicMovie:Any){
      
        guard let dicJSON:[String:Any] = dicMovie as? [String:Any],
        let titleStr:String = dicJSON["title"] as! String?,
        //let yearStr:Int = dicJSON["year"] as! Int?,
        //let overviewStr:String = dicJSON["overview"] as! String?,
        let dicIds: [String:Any] = dicJSON["ids"] as! [String : Any]?
           // ,let imdbStr:String  = dicIds["imdb"] as! String?
            else {return nil}
        
        title=titleStr
       // year=yearStr
        
        overview = dicJSON["overview"] as? String ?? ""
        imdb = dicIds["imdb"] as? String ?? ""
        year = dicJSON["year"] as? Int ?? 0
        //imdb=imdbStr
        
        //Found with / at the end of som imbdCodes
        imdb = imdb?.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range:nil)
        
    }
    
    init?(dicSearch:Any){
        
        guard let dicJSON:[String:Any] = dicSearch as? [String:Any],
            let dicMovie:[String:Any] = dicJSON["movie"] as? [String:Any] else {return nil}
        
        self.init(dicMovie:dicMovie)
        
        
    }
}




extension Movie: Equatable { }

func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.title == rhs.title && lhs.year == rhs.year && lhs.imdb == rhs.imdb
}

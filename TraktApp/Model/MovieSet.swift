//
//  Movie.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 18/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//


import Foundation

struct MovieSet {
    var  movies:[Movie] = []
    
      init?(arrPopular:Any){
        
        guard let arrJSON:[AnyObject] = arrPopular as? [AnyObject] else {return nil}
        
        for dicMovie in arrJSON{
            if let movie = Movie(dicMovie:dicMovie){
                movies.append(movie)
            }
        }
    }

    init?(arrSearch:Any){
        
        guard let arrJSON:[AnyObject] = arrSearch as? [AnyObject] else {return nil}
        
        for dicMovie in arrJSON{
            if let movie = Movie(dicSearch:dicMovie){
                movies.append(movie)
            }
        }
    }
    
}

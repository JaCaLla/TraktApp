//
//  ImageProvider.swift
//  ScratchingImageTableviews
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/08/16.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import Foundation
import UIKit

class ImageProvider{
    
    let movie:Movie
    private let operationQueue = OperationQueue()
    
    
    init(movie:Movie, completion:@escaping (UIImage?,URL?) -> ()){
        self.movie = movie
        
        if (movie.imdb?.characters.count)! > 0{
            let fetchImageURLOp = FetchImageURLOp(imdb: movie.imdb!)
            let fetchImageOp = FetchImageOp(url: nil, completion: completion)

            let operations = [fetchImageURLOp,fetchImageOp]
            
            fetchImageOp.addDependency(fetchImageURLOp)

            
             operationQueue.addOperations(operations, waitUntilFinished: false)
        }else{
            let fetchImageOp = FetchImageOp(url: URL(string:"https://az853139.vo.msecnd.net/static/images/not-found.png"), completion: completion)
            
            let operations = [fetchImageOp]
            
            
            operationQueue.addOperations(operations, waitUntilFinished: false)
        }
        
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

extension ImageProvider: Hashable {
    var hashValue: Int {
        return (movie.title + "\(movie.pictureURL)").hashValue
    }
}

func ==(lhs: ImageProvider, rhs: ImageProvider) -> Bool {
    return lhs.movie == rhs.movie
}

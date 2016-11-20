//
//  ImageProvider.swift
//  ScratchingImageTableviews
//
//  Created by JAVIER CALATRAVA LLAVERIA on 15/08/16.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import Foundation
import UIKit

class ImageProviderUC{
    
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
            let fetchImageOp = FetchImageOp(url: URL(string:"http://www.isopractic.es/new/wp-content/uploads/2016/05/placeholder-348x348.gif"), completion: completion)
            
            let operations = [fetchImageOp]
            
            operationQueue.addOperations(operations, waitUntilFinished: false)
        }
    }
    
    func cancel() {
        operationQueue.cancelAllOperations()
    }
}

extension ImageProviderUC: Hashable {
    var hashValue: Int {
        return (movie.title + "\(movie.pictureURL)").hashValue
    }
}

func ==(lhs: ImageProviderUC, rhs: ImageProviderUC) -> Bool {
    return lhs.movie == rhs.movie
}

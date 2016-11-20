//
//  FetchImageURLOp.swift
//  
//
//  Created by JAVIER CALATRAVA LLAVERIA on 20/11/2016.
//
//

import Foundation

class FetchImageURLOp: ConcurrentOperation {
    
    private let imdb: String
    private let completion: ((URL?) -> ())?
    
     var url: URL?
    
    init(imdb: String, completion: ((URL?) -> ())? = nil) {
        self.imdb = imdb
        self.completion = completion
        super.init()
    }
    
    override func main() {
        
        ImdbService.sharedInstance.fetchImageURL(imdbId: self.imdb,
        success: { [unowned self]
            urlReceived in
            self.url = urlReceived
            self.state = .Finished
        },serverFailure: { [unowned self] (error) in
            self.state = .Finished
        },businessFailure: { [unowned self] (error) in
            self.state = .Finished
        }
        )
        

    }
}

extension FetchImageURLOp: ImageURLOperationProvider {
    var imageURL: URL? { return url }
}

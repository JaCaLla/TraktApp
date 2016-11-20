//
//  FetchImage.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 20/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

protocol ImageURLOperationProvider {
    var imageURL: URL? { get }
}

class FetchImageOp: ConcurrentOperation {
    
    private let inputURL: URL?
    private let completion: ((UIImage,URL?) -> ())?
    private var outputImage: UIImage?

    
    init(url: URL?, completion: ((UIImage,URL?) -> ())? = nil) {
        inputURL = url
        self.completion = completion
        super.init()
    }
    
    override func main() {
        let imageURL: URL?
        if let _inputURL = inputURL {
            imageURL = _inputURL
        } else {
            let dataProvider = dependencies
                .filter { $0 is ImageURLOperationProvider }
                .first as? ImageURLOperationProvider
    
            
            imageURL = dataProvider?.imageURL
        }
        
        guard let url = imageURL else { return }
        
        if let _data = NSData(contentsOf: url),
            let outputImage = UIImage(data:_data as Data){

            self.completion?(outputImage,url)

            self.state = .Finished

        }else{
            if  let _url =  URL(string:"https://az853139.vo.msecnd.net/static/images/not-found.png"),
                let _data = NSData(contentsOf:_url),
            let outputImage = UIImage(data:_data as Data){
             
                self.completion?(outputImage,url)
                
            }
            
            
           
 
        }
        
        
        
    }
    
    
}

//
//  MovieTVC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

class MovieTVC: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var imvPoster: UIImageView!
    var movie:Movie?{
        didSet{
            if let title = movie?.title{
                self.lblTitle.text = title
                updateImageViewWithImage()
            }
            if let year = movie?.year, year>0 {
                self.lblYear.text = String(year)
            }
            if let overview = movie?.overview{
                self.lblOverview.text = overview
            }
            
        }
    }

    func updateImageViewWithImage(image: UIImage?=nil) {
 
        
        if let image = image {
            imvPoster.image = image
            imvPoster.alpha = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.imvPoster.alpha = 1.0
                self.activityIndicator.alpha = 0
            }, completion: { [unowned self]
                _ in
                self.activityIndicator.stopAnimating()
            })
            
        } else {
            imvPoster.image = nil
            imvPoster.alpha = 0
            activityIndicator.alpha = 1.0
            activityIndicator.startAnimating()
        }
    }

}

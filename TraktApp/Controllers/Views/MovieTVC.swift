//
//  MovieTVC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

class MovieTVC: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    var movie:Movie?{
        didSet{
            if let title = movie?.title{
                self.lblTitle.text = title 
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  MovieSearchBar.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

protocol MovieSearchBarDelegate: class {
    func onRequestNewSearch(query:String)
    func onSearchCancel()
    func onSearchDone()
    
}


class MovieSearchBar: UISearchBar, UISearchBarDelegate {
    
    weak var movieSearchBarDelegate:MovieSearchBarDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self._setupView()
    }
    
    // UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){

        self.movieSearchBarDelegate?.onRequestNewSearch(query: searchText)
      
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        self.text = ""
        self.showsCancelButton = false
        self.movieSearchBarDelegate?.onSearchCancel()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        self.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.movieSearchBarDelegate?.onSearchDone()
        self._enableCancelButton(searchBar)

    }
    
    

    // MARK : - Internal/Private
    
    private func _setupView(){
        self.delegate = self
        self.keyboardAppearance = UIKeyboardAppearance.dark
    }


    private func _enableCancelButton(_ searchBar: UISearchBar){
        for view in searchBar.subviews {
            for subview in view.subviews {
                if let button = subview as? UIButton {
                    button.isEnabled = true
                }
            }
        }
    }
    
}

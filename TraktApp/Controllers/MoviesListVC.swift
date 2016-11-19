//
//  MoviesListVC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

class MoviesListVC: UIViewController,MoviesListViewDelegate {

    enum ShowingMode {
        case popularListMode
        case searchListMode(String)
    }

    let showingMode:ShowingMode = ShowingMode.popularListMode
    
    @IBOutlet weak var moviesListView: MoviesListView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.loadPopular()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - MoviesListViewDelegate
    func onRequestMovieSet(completion: @escaping ((MovieSet) -> Void)) {
        
        switch self.showingMode {
        case .popularListMode:
            MostPopularUC.sharedInstance.next(success: {
                moviesSet in
                completion(moviesSet)
            },serverFailure: { (error) in
                // FIXME
                print("TODO")
            },businessFailure: { (error) in
                // FIXME
                print("TODO")
            })
        default: break
            
        }


    }
    

    // MARK: - Private/Internal
    func setupUI(){
        moviesListView.moviesListViewdelegate = self
    }
    
    func loadPopular(){
        
        MostPopularUC.sharedInstance.first(success: {[unowned self]
                                            moviesSet in
                                            
                                            self.moviesListView.initialMoviesSet(moviesSet: moviesSet)
        },serverFailure: { (error) in
            // FIXME
            print("TODO")
        },businessFailure: { (error) in
            // FIXME
            print("TODO")
        }
        )
        
    }


}

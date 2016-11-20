//
//  MoviesListVC.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit


class MoviesListVC: UIViewController,MoviesListViewDelegate,MovieSearchBarDelegate {

    enum ShowingMode {
        case popularListMode
        case searchListMode(String)
    }

    var showingMode:ShowingMode = ShowingMode.popularListMode
    
    @IBOutlet weak var moviesListView: MoviesListView!
    @IBOutlet weak var movieSearchBar: MovieSearchBar!

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self._setupUI()
        self._loadPopular()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - MoviesListViewDelegate
    func onRequestANewMovieSet(completion: @escaping ((MovieSet) -> Void)) {
        
        switch self.showingMode {
        case .popularListMode:
            MostPopularUC.sharedInstance.next(success: {
                moviesSet in
                completion(moviesSet)
            },serverFailure: { (error) in
                self._showServerError()
            },businessFailure: { (error) in
                self._showBusinesError()
            })
        case .searchListMode(let query):
            SearchMovieUC.sharedInstance.next(query:query,success: {
                moviesSet in
                completion(moviesSet)
            },serverFailure: { (error) in
                self._showServerError()
            },businessFailure: { (error) in
                self._showBusinesError()
            })
            
        }
    }
    
    // MARK : - MovieSearchBarDelegate
    func onRequestNewSearch(query:String){
        
        self.showingMode = .searchListMode(query)
        
        SearchMovieUC.sharedInstance.first(query: query,success: {[unowned self]
            moviesSet in
            
            self.moviesListView.initialMoviesSet(moviesSet: moviesSet)
            },serverFailure: { (error) in
                self._showServerError()
        },businessFailure: { (error) in
            self._showBusinesError()
        }
        )
    }

    func onSearchCancel(){
        
        switch self.showingMode {
        case .popularListMode: break

        case .searchListMode:
            self.showingMode = .popularListMode
            self._loadPopular()
        }

          view.endEditing(true)
    }
    
    func onSearchDone() {
        view.endEditing(true)
    }
    

    // MARK: - Private/Internal
    func _setupUI(){
        moviesListView.moviesListViewdelegate = self
        movieSearchBar.movieSearchBarDelegate = self
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black

    }
    
    func _loadPopular(){
        
        MostPopularUC.sharedInstance.first(success: {[unowned self]
                                            moviesSet in
                                            
                                            self.moviesListView.initialMoviesSet(moviesSet: moviesSet)
        },serverFailure: { (error) in
             self._showServerError()
        },businessFailure: { (error) in
            self._showBusinesError()
        }
        )
        
    }
    
    func _showServerError(){
        self._showAlertError(message: "Error with server!")
    }
    
    func _showBusinesError(){
        self._showAlertError(message: "Busines error!")
    }
    
    func _showAlertError(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}

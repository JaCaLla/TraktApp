//
//  MoviesListView.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

protocol MoviesListViewDelegate: class {
    func onRequestMovieSet(completion: @escaping ((MovieSet) -> Void))
}


class MoviesListView: UITableView, UITableViewDataSource,UITableViewDelegate {

    weak var moviesListViewdelegate:MoviesListViewDelegate?
    
    var moviesList:[Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
    }
    
    // MARK : - Public/Helpers
    public func initialMoviesSet(moviesSet:MovieSet){
        self.moviesList = moviesSet.movies
        
        self.refreshView()
    }
    
    public func addMoviesSet(moviesSet:MovieSet){
        self.moviesList += moviesSet.movies
        
        self.refreshView()
    }
    
    
    // MARK : - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.moviesList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let movieTVC = self.dequeueReusableCell(withIdentifier: "MovieTVC")! as! MovieTVC
       movieTVC.movie = self.moviesList[indexPath.row]
        
        if(indexPath.row == self.moviesList.count - 1 ){
            moviesListViewdelegate?.onRequestMovieSet(completion: { [unowned self] moviesSet in
                self.moviesList += moviesSet.movies
                
                DispatchQueue.main.async {
                     self.refreshView()
                }
               
            })
        }
        
        return movieTVC
    }
    
    
    // MARK : - UITableViewDataSource
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        //FIXME
        print("todo")
    }
    

    
    
    // MARK : - Internal/Private
    
    private func setupView(){
        self.dataSource = self
        self.delegate = self
        
        
        self.refreshView()
    }

    
    private func refreshView(){
        
        self.reloadData()

    }

}

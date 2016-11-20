//
//  MoviesListView.swift
//  TraktApp
//
//  Created by JAVIER CALATRAVA LLAVERIA on 19/11/2016.
//  Copyright © 2016 JAVIER CALATRAVA LLAVERIA. All rights reserved.
//

import UIKit

protocol MoviesListViewDelegate: class {
    func onRequestANewMovieSet(completion: @escaping ((MovieSet) -> Void))
}


class MoviesListView: UITableView, UITableViewDataSource,UITableViewDelegate {

    weak var moviesListViewdelegate:MoviesListViewDelegate?
    
    var moviesList:[Movie] = []
    let cache = NSCache<NSString, UIImage>()
    var imageProviders = Set<ImageProvider>()
    
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
            moviesListViewdelegate?.onRequestANewMovieSet(completion: { [unowned self] moviesSet in
                if (moviesSet.movies.count>0){
                    self.moviesList += moviesSet.movies
                    
                    DispatchQueue.main.async {
                        self.refreshView()
                    }
                }

               
            })
        }
        
        return movieTVC
    }
    
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        
        guard let cell = cell as? MovieTVC else { return }
        
        var movie:Movie = self.moviesList[indexPath.row]
        
        guard cache.object( forKey: "\(movie.pictureURL)" as NSString) != nil  else {
            
            let imageProvider = ImageProvider( movie:movie) { [unowned self]
                image,url in
                OperationQueue.main.addOperation {
                    
                    if(indexPath.row>=self.moviesList.count){
                        return
                    }
                    movie.pictureURL=url
                    self.moviesList[indexPath.row]=movie
                    self.cache.setObject(image!, forKey: "\(movie.pictureURL)" as NSString)
                    

                    if(self._isVisible(indexpath: indexPath as NSIndexPath, tableView: tableView)){
                        cell.updateImageViewWithImage(image: image)
                    }
                }
                
                return
            }
            imageProviders.insert(imageProvider)
            return
        }
        
        
        let key = "\(movie.pictureURL)" as NSString
        let image:UIImage = self.cache.object(forKey: key)! 
        cell.updateImageViewWithImage(image: image)
        
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
        
        self.separatorColor = UIColor.clear
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
        
        self.refreshView()
    }

    
    private func refreshView(){
        
        self.reloadData()

    }

    func _isVisible(indexpath:NSIndexPath, tableView:UITableView) ->Bool{
        if let _ =  tableView.indexPathsForVisibleRows!.filter({$0.row == indexpath.row}).first {
            return true
        }
        return false
    }
}

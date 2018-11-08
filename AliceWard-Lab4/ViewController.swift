//
//  ViewController.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/21/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//
// Icons for Tab Bar from: <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
// <div>Icons made by <a href="https://www.flaticon.com/authors/icon-works" title="Icon Works">Icon Works</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pinwheel: UIActivityIndicatorView!
    @IBOutlet weak var collection: UICollectionView!
    
    var apiData:APIResults!
    var movie:Movie!
    var theImageCache = [UIImage]()
    var movieSearch = ""
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieSearch = (searchBar.text?.replacingOccurrences(of: " ", with: "+"))!
        
        apiData.results.removeAll()
        theImageCache.removeAll()
        
        self.pinwheel.layer.zPosition = 1
        self.pinwheel.startAnimating()
        pinwheel.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        pinwheel.backgroundColor = UIColor(red:0.49, green:0.49, blue:0.49, alpha:0.5)
        self.pinwheel.isHidden = false
        pinwheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        

        
        DispatchQueue.global(qos: .userInitiated).async{
            self.fetchData()
            self.cacheImages()
            DispatchQueue.main.async {
                self.collection.reloadData()
                self.pinwheel.stopAnimating()
                self.pinwheel.isHidden = true
                
            }
        }
    }
    
    //Fetching data from TMDB
    func fetchData() {
        apiData.results.removeAll()
        theImageCache.removeAll()
        let url = URL(string:"https://api.themoviedb.org/3/search/movie?api_key=e29bad5fcd03ee0ac32615c400da7473&query=\(movieSearch)&append")
        let data = try! Data(contentsOf: url!)
        apiData = try! JSONDecoder().decode(APIResults.self, from: data)
    }
    
    //Fetching specific details about movie
    func fetchDataAgain() {
        for results in apiData.results {
            let id:Int
            id = results.id
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(describing: id))?api_key=e29bad5fcd03ee0ac32615c400da7473&language=en-US&page=1")
            let data = try! Data(contentsOf: url!)
            movie = try! JSONDecoder().decode(Movie.self, from: data)
        }
    }
    
    //Loads the home page with top rated movies from TMDB
    func fetchDataForHomePage() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=e29bad5fcd03ee0ac32615c400da7473&language=en-US&page=1")
        let data = try! Data(contentsOf: url!)
        apiData = try! JSONDecoder().decode(APIResults.self, from: data)
    }
    
    func cacheImages() {
        theImageCache.removeAll()
        var url = URL(string: "")
        for results in apiData.results {
            if results.poster_path == nil {
                url = URL(string: "https://via.placeholder.com/350x150") // C/O https://placeholder.com/
            } else{
                url = URL(string: "https://image.tmdb.org/t/p/w500/"+results.poster_path!)
            }
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)
        self.theImageCache.append(image!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return theImageCache.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"MyCell", for: indexPath) as! Cell
        cell.smallMovieTitle.text = apiData.results[indexPath.row].title
        cell.smallMovieImage.image = theImageCache[indexPath.row]
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        return cell
    }
    
    //Collection view to DetailedViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detailed" {
            let destination = segue.destination as? DetailedViewController
            let movies = sender as! Int
            let image = sender as! Int
            destination!.movie = apiData.results[movies]
            destination!.moviePoster = theImageCache[image]
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Detailed", sender: indexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pinwheel.isHidden = true
        self.title = "Movies"

        fetchDataForHomePage()
        self.collection.delegate = self
        self.collection.dataSource = self
        self.searchBar.delegate = self

        DispatchQueue.global(qos: .userInitiated).async {
            self.cacheImages()
            self.fetchDataForHomePage()
            self.fetchDataAgain()
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


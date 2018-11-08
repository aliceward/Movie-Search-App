//
//  DetailedViewController.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/21/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieRelease: UILabel!
    
    @IBOutlet weak var tmdbAttribution: UIImageView!
    
    var movie:Movie!
    var info:String!
    var favMovies:[String] = []
    var moviePoster:UIImage!
    var overview:String!
    var rating:String!
    var nameOfMovie:String!
    
    //Creative - added alerts when movie is already added - from https://learnappmaking.com/uialertcontroller-alerts-swift-how-to/
    @IBAction func addToFavs(_ sender: UIButton) {
        var favoriteTitles = UserDefaults.standard.array(forKey: "Favorites") as? [String]
        
        //First checking to see if favorites is nill
        if favoriteTitles == nil {
            favoriteTitles = []
        }
        //Checking to see if the movie has already been added to favorites
        var alreadyFavorited = false
            for title in favoriteTitles! {
            let checkTitle = String(describing: title)
                if checkTitle == movie.title {
                    alreadyFavorited = true
                    let alert = UIAlertController(title: "Movie Not Added", message: "You have already added this movie to your favorites! Seems like you must really love it!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        //If it has not, then the movie is added to favorites
        if alreadyFavorited == false {
            favoriteTitles?.append(movie.title)
            UserDefaults.standard.set(favoriteTitles, forKey: "Favorites")
            let alert = UIAlertController(title: "Movie Added", message: "What a great movie!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    //Creative - added alerts when movie is already added - from https://developer.apple.com/documentation/uikit/uialertcontroller
    @IBAction func addToWatchList(_ sender: Any) {
        var watchListTitles = UserDefaults.standard.array(forKey: "WatchList") as? [String]
        
        if watchListTitles == nil {
            watchListTitles = []
        }
        var alreadyAdded = false
        for title in watchListTitles! {
            let checkTitle = String(describing: title)
            if checkTitle == movie.title {
                alreadyAdded = true
                let alert = UIAlertController(title: "Movie Not Added", message: "You have already added this movie to your watch list! Seems like you need to watch it soon!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        if alreadyAdded == false {
            watchListTitles?.append(movie.title)
            UserDefaults.standard.set(watchListTitles, forKey: "WatchList")
            let alert = UIAlertController(title: "Movie Added", message: "Time to watch it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poster.image = moviePoster
        
        //Rounding corners of movie poster to make it look nicer - from Stack Overflow: https://stackoverflow.com/questions/25476139/how-do-i-make-an-uiimage-view-with-rounded-corners-cgrect-swift
        self.poster.layer.cornerRadius = 8
        self.poster.clipsToBounds = true
        
        movieTitle.text = movie.title
        movieRelease.text = movie.release_date
        movieScore.text = movie.overview
        movieRating.text = String(movie.popularity)
        tmdbAttribution.image = UIImage(named: "tmdb")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

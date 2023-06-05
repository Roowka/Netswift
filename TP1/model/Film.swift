//
//  Film.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//
// Data for film details

import Foundation

class Film : Decodable{
    let original_title: String;
    let overview: String;
    let vote_average: Float;
    let release_date: String;
    let genres: Array<DataFilmGenre>;
    let tagline:String
    let poster_path:String
    let backdrop_path:String
    let runtime:Int
    
    struct DataFilmGenre: Decodable, Identifiable, Hashable{
        let id: Int
        let name: String
    }
    
    
    init(original_title:String, overview:String, vote_average:Float, release_date:String, genres:Array<DataFilmGenre>, tagline:String, poster_path:String, backdrop_path:String, runtime:Int) {
        self.original_title = original_title
        self.overview = overview
        self.vote_average = vote_average
        self.release_date = release_date
        self.genres = genres
        self.tagline = tagline
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.runtime = runtime
    }
    
    // Function that returns the average rating of a movie in stars
    func getStars() -> String{
        let stars = Int(self.vote_average / 2)
        var starsString = ""
        for _ in 0...stars{
            starsString += "⭐"
        }
        return starsString
    }
    
    // Function that returns the release year of a movie
    func getReleaseYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self.release_date)!
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
}

//
//  Film.swift
//  TP1
//
//  Created by digital on 17/04/2023.
//

import Foundation

class Film : Decodable{
    var original_title: String;
    var overview: String;
    var vote_average: Float;
    var release_date: String;
    var genres: Array<DataFilmGenre>;
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
    
    func getStars() -> String{
        var stars = Int(self.vote_average / 2)
        var starsString = ""
        for _ in 0...stars{
            starsString += "⭐"
        }
        return starsString
    }
    
    func getReleaseYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self.release_date)!
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        return yearString
    }
}

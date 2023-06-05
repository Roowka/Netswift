//
//  ShortFilmData.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import Foundation

struct ShortFilmData : Decodable, Hashable{
    let id:Int
    let original_title: String;
    let overview:String
    let poster_path:String
    let genre_ids: [Int]
    let vote_average:Float
    
    func get_poster() -> String{
        return "https://www.themoviedb.org/t/p/w154/"+self.poster_path
    }
    
    func getStars() -> Float{
        let nbStars = round((vote_average/2)*10) / 10
        return nbStars
    }

}

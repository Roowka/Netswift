//
//  ShortFilmData.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import Foundation

struct ShortFilmData : Decodable, Hashable{
    var id:Int
    var original_title: String;
    let overview:String
    let poster_path:String
    let genre_ids: [Int]
    
    func get_poster() -> String{
        return "https://www.themoviedb.org/t/p/w154/"+self.poster_path
    }
    
    
//    init(id: Int, original_title: String, overview: String, poster_path: String) {
//        self.original_title = original_title
//        self.overview = overview
//        self.poster_path = poster_path
//        self.id = id
//    }

}

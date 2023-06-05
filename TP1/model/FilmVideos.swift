//
//  FilmVideos.swift
//  TP1
//
//  Created by digital on 05/06/2023.
//
//  List of videos related to films

import Foundation

class FilmVideos : Decodable{
    let id:Int
    let results: [FilmVideosData]
    
    // Function that returns the first object whose type is equal to the parameter
    func getVideoData(byType type: String) -> FilmVideosData? {
        return results.first { $0.type == type }
    }
}


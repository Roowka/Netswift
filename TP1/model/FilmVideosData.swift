//
//  FilmVideos.swift
//  TP1
//
//  Created by digital on 05/06/2023.
//
//  data of videos related to films

import Foundation

struct FilmVideosData : Decodable, Hashable{
    let key:String
    let site:String
    let name:String
    let type:String
}

//
//  FilmDetailsController.swift
//  TP1
//
//  Created by digital on 05/06/2023.
//

import Foundation
import SwiftUI

class FilmDetailsController: ObservableObject {
    
    let api_url:String = "https://api.themoviedb.org/3/movie/"
    let api_key:String = "api_key=9a8f7a5168ace33d2334ba1fe14a83fb"
    let currentLocale = "&language="+(Locale.preferredLanguages.first ?? "fr-FR");

    func fetch(movie_id:Int) async -> Film?{
        let filmUrl = URL(string: api_url+String(movie_id)+"?"+api_key + currentLocale)!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: filmUrl)
            let (data, response) = try await session.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return nil
            }
            guard String(data: data, encoding: .utf8) != nil else {
                print("Impossible de convertir les données en chaîne JSON")
                return nil
            }
            let responseFilm = try JSONDecoder().decode(Film.self, from:data)
            return responseFilm
        } catch {
            print(error)
            return nil
        }
    }
    
    //  Function to get videos related to a movie
    func fetch_videos(url:String) async -> FilmVideos?{
        let filmUrl = URL(string: url + currentLocale)!
        let session = URLSession.shared
        do {
            let request = URLRequest(url: filmUrl)
            let (data, response) = try await session.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Réponse invalide")
                return nil
            }
            guard String(data: data, encoding: .utf8) != nil else {
                print("Impossible de convertir les données en chaîne JSON")
                return nil
            }
            let responseFilm = try JSONDecoder().decode(FilmVideos.self, from:data)
            return responseFilm
        } catch {
            print(error)
            return nil
        }
    }
    
    // Function to get the trailer of a movie, it calls the function to get the videos related to the movie and returns the one of the trailer
    func getTrailerUrl(movie_id:Int) async -> String{
        var final_url = "https://www.youtube.com/watch?v="
        let api_trailer_url:String = "https://api.themoviedb.org/3/movie/"+String(movie_id)+"/videos?"+api_key
        let filmVideos: FilmVideos? = await fetch_videos(url: api_trailer_url)
        if let infosVideo:FilmVideosData = filmVideos?.getVideoData(byType: "Trailer"){
            final_url += infosVideo.key
        }
        return final_url
    }
}

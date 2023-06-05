//
//  FilmListByGenreController.swift
//  TP1
//
//  Created by digital on 05/06/2023.
//

import Foundation

class FilmListByGenreController: ObservableObject {

    let url:String = "https://api.themoviedb.org/3/discover/movie?api_key=9a8f7a5168ace33d2334ba1fe14a83fb&sort_by=popularity.desc&with_genres="

    // Function to get a list of the latest movies from TMDB api
    func fetch(id_genre:Int) async -> ShortFilm?{
        let filmUrl = URL(string: url + String(id_genre))!
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
            let responseList = try JSONDecoder().decode(ShortFilm.self, from:data)
            return responseList
        } catch {
            print(error)
            return nil
        }
    }
}

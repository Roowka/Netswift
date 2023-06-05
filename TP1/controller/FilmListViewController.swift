//
//  FilmListViewController.swift
//  TP1
//
//  Created by digital on 05/06/2023.
//

import Foundation

class FilmListViewController: ObservableObject {
    
    let api_key:String = "api_key=9a8f7a5168ace33d2334ba1fe14a83fb"

    func fetch(url:String) async -> ShortFilm?{
        let filmUrl = URL(string: url + api_key)!
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

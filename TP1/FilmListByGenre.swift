//
//  FilmListByGenre.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import SwiftUI

struct FilmListByGenre: View {
    
    @State var filmListByGenre: ShortFilm? = nil
    
    func fetch(url:String) async -> ShortFilm?{
                let filmUrl = URL(string: url)!
                let session = URLSession.shared
                do {
                    let request = URLRequest(url: filmUrl)
                    let (data, response) = try await session.data(for: request)
                        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        print("Réponse invalide")
                        return nil
                    }
                    guard let jsonString = String(data: data, encoding: .utf8) else {
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
    
    var body: some View {
        VStack{
            Text("Hello world bg")
        }
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .foregroundColor(.white)
        .background(.black)
        .onAppear{
            Task{
                filmListByGenre = await fetch(url: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=9a8f7a5168ace33d2334ba1fe14a83fb")
            }
        }
    }
}

struct FilmListByGenre_Previews: PreviewProvider {
    static var previews: some View {
        FilmListByGenre()
    }
}

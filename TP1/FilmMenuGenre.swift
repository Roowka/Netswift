//
//  FilmMenuGenre.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import SwiftUI

struct FilmMenuGenre: View {
    
    @State var filmListGenre: FilmGenre? = nil
    
    let api_key:String = "api_key=9a8f7a5168ace33d2334ba1fe14a83fb"
    
    func fetch(url:String) async -> FilmGenre?{
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
                    let responseList = try JSONDecoder().decode(FilmGenre.self, from:data)
                    return responseList
                } catch {
                    print(error)
                    return nil
                }
    }
    
    var body: some View {
        VStack{
            if let filmListGenre = self.filmListGenre{
                
                HStack() {
                    Text("Select a genre")
                        .font(.title)
                        .frame(width: 200, height: 100)
                    
                    Spacer()
                    
                    Text("﹀")
                }
                
                ScrollView(.vertical) {
                    VStack{
                        ForEach(filmListGenre.genres, id: \.self){
                            genre in
                            HStack{
                                NavigationLink(destination: FilmListByGenre(idGenre: genre.id, nameGenre: genre.name)){
                                    Text(genre.name)
                                }
                            }
                            .padding()
                        }
                    }
                    .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 0,
                          maxHeight: .infinity,
                          alignment: .top
                        )
                    .padding()
                }
            }
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
                filmListGenre = await fetch(url: "https://api.themoviedb.org/3/genre/movie/list?"+api_key)
            }
        }
    }
}

struct FilmMenuGenre_Previews: PreviewProvider {
    static var previews: some View {
        FilmMenuGenre()
    }
}

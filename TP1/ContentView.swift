//
//  ContentView.swift
//  TP1
//
//  Created by digital on 04/04/2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    init(id:Int){
        self.movie_id = id
    }

    @State var film: Film? = nil
    
    let movie_id:Int
    
    func fetch() async -> Film?{
                let filmUrl = URL(string: "https://api.themoviedb.org/3/movie/"+String(movie_id)+"?api_key=9a8f7a5168ace33d2334ba1fe14a83fb")!
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
                    let responseFilm = try JSONDecoder().decode(Film.self, from:data)
                    return responseFilm
                } catch {
                    print(error)
                    return nil
                }
    }
    
    var body: some View {
        
        VStack {
            if let film = self.film {
                
                HStack{
                    AsyncImage(url: URL(string: "https://www.themoviedb.org/t/p/w780/"+film.backdrop_path))
                        .frame(width: 200, height: 200)
                }

                HStack{
                  
                    AsyncImage(url: URL(string: "https://www.themoviedb.org/t/p/w154/"+film.poster_path))
                        .frame(width: 180, height: 200)
                    
                    Text(film.original_title)
                        .padding(.top, 100)
                        .font(.largeTitle)
                        .frame(width: 200, height: 250)

                }
                
                HStack{
                    Text(film.getStars())
                }
                .padding()

                HStack{
                    
                    Text(film.getReleaseYear())
                    
                    Text("-")
                    
                    ForEach(film.genres){
                        item in
                        Text(item.name + ",")
                    }
                }
                Spacer()
                
                HStack{
                    Text(film.overview)
                }
                .frame(width: 350, height: 150)
                
                Spacer()
                
                    Button(action: {
                        if let url = URL(string: "https://www.youtube.com/watch?v=b7D1l9ho6ZI") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack{
                            Text("Watch Now")
                                .foregroundColor(Color.white)
                                .frame(width: 300, height: 50)
                                .background(RoundedRectangle(cornerRadius: 25)
                                    .fill(.red).shadow(radius: 10))
                    }
                }
                    
                Spacer();
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
                film = await fetch();
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(id: 502356)
    }
}

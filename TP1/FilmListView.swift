//
//  FilmListView.swift
//  TP1
//
//  Created by digital on 22/05/2023.
//

import SwiftUI

struct FilmListView: View {
    
    @State var filmList: ShortFilm? = nil
    @State var filmListTopRated: ShortFilm? = nil
    
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
            
            HStack{
                Image("NetflixLogo")
                    .resizable()
                    .frame(width: 40.0, height: 65.0)
                
                Spacer()
                
                Text("Series")
                
                Spacer()
                
                Text("Films")
                
                Spacer()
                
                Text("My list")
            }
            .padding()
            
            
            ScrollView(.vertical) {
                HStack() {
                    Text("Popular movies")
                        .font(.largeTitle)
                        .frame(width: 250, height: 100)
                    
                    Spacer()
                    
                    Text("﹀")
                }
                
                ScrollView(.horizontal) {
                    VStack{
                        if let filmList = self.filmList {
                            HStack{
                                ForEach(filmList.results, id: \.self) { film in
                                    VStack{
                                        AsyncImage(url: URL(string: film.get_poster()))
                                            .frame(width: 154, height: 235)
                                        
                                        Text(film.original_title)
                                            .font(.headline)
                                            .frame(width: 154, height: 75)
                                    }
                                }
                            }
                        }
                    }
                }
                
                HStack() {
                    Text("Top rated")
                        .font(.largeTitle)
                        .frame(width: 150, height: 100)
                    
                    Spacer()
                    
                    Text("﹀")
                }
                
                ScrollView(.horizontal) {
                    VStack{
                        if let filmListTopRated = self.filmListTopRated {
                            HStack{
                                ForEach(filmListTopRated.results, id: \.self) { film in
                                    VStack{
                                        AsyncImage(url: URL(string: film.get_poster()))
                                            .frame(width: 154, height: 235)
                                        
                                        Text(film.original_title)
                                            .font(.headline)
                                            .frame(width: 154, height: 75)
                                    }
                                }
                            }
                        }
                    }
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
                filmList = await fetch(url: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&api_key=9a8f7a5168ace33d2334ba1fe14a83fb")
                
                filmListTopRated = await fetch(url: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200&api_key=9a8f7a5168ace33d2334ba1fe14a83fb")
                
            }
        }
    }
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}

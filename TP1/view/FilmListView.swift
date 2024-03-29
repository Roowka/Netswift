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
    @StateObject private var apiController = FilmListViewController()
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                HStack{
                    Image("NetflixLogo")
                        .resizable()
                        .frame(width: 40.0, height: 65.0)
                    
                    Spacer()
                    
                    Text("Series")
                    
                    Spacer()
                    
                    NavigationLink(destination: FilmMenuGenre()){
                        Text("Films")
                    }
                    
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
                                        NavigationLink(destination: FilmDetails(id: film.id)){
                                            VStack{
                                                AsyncImage(url: URL(string: film.get_poster()))
                                                    .frame(width: 154, height: 235)
                                                
                                                Text(film.title)
                                                    .font(.headline)
                                                    .frame(width: 154, height: 75)
                                                
                                                Text(film.overview)
                                                    .frame(width: 154, height: 75)
                                            }
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
                                        NavigationLink(destination: FilmDetails(id: film.id)){
                                            VStack{
                                                AsyncImage(url: URL(string: film.get_poster()))
                                                    .frame(width: 154, height: 235)
                                                
                                                Text(film.title)
                                                    .font(.headline)
                                                    .frame(width: 154, height: 75)
                                                
                                                Text(film.overview)
                                                    .frame(width: 154, height: 75)
                                            }
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
                    filmList = await apiController.fetch(url: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&")
                    
                    filmListTopRated = await apiController.fetch(url: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=vote_average.desc&without_genres=99,10755&vote_count.gte=200&")
                    
                }
            }
        }
    }
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}

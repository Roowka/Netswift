//
//  FilmDetails.swift
//  TP1
//
//  Created by digital on 04/04/2023.
//

import SwiftUI
import UIKit

struct FilmDetails: View {
    
    init(id:Int){
        self.movie_id = id
        self.trailer_url = ""
    }

    @State var trailer_url:String
    @State var film: Film? = nil
    @StateObject private var apiController = FilmDetailsController()
    
    let movie_id:Int
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                if let film = self.film {
                    
                    HStack{
                        AsyncImage(url: URL(string: "https://www.themoviedb.org/t/p/w780/"+film.backdrop_path))
                            .frame(width: 200, height: 200)
                            .padding(.top, -50)
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
                        Text(String(film.runtime) + " minutes")
                        Spacer()
                        Button(action: {
                            if let url = URL(string: trailer_url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack{
                                Text("Trailer")
                                    .foregroundColor(Color.white)
                                    .frame(width: 75, height: 25)
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(.gray).shadow(radius: 10))
                            }
                        }
                        Spacer()
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
                    .frame(width: 350, height: 120)
                    
                    Spacer()
                    
                    HStack{
                        Text("Watch Now")
                            .foregroundColor(Color.white)
                            .frame(width: 300, height: 50)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .fill(.red).shadow(radius: 10))
                    }
    
                    Spacer();
                }
                
            }
            .onAppear{
                Task{
                    film = await apiController.fetch(movie_id: movie_id);
                    trailer_url = await apiController.getTrailerUrl(movie_id: movie_id)
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
    }
}

struct FilmDetails_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetails(id: 502356)
    }
}

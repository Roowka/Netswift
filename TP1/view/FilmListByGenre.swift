//
//  FilmListByGenre.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import SwiftUI

struct FilmListByGenre: View {
    
    var idGenre:Int
    var nameGenre:String
    @StateObject private var apiController = FilmListByGenreController()
    
    init(idGenre:Int, nameGenre:String){
        self.idGenre = idGenre
        self.nameGenre = nameGenre
    }
    
    @State var filmListByGenre: ShortFilm? = nil
    
    var body: some View {
        VStack{
            if let filmListByGenre = self.filmListByGenre{
                
                HStack() {
                    Text(nameGenre)
                        .font(.title)
                        .frame(width: 200, height: 100)
                    
                    Spacer()
                    
                    Text("﹀")
                }
                
                ScrollView(.vertical){
                    ForEach(filmListByGenre.results, id: \.self){
                        film in
                        ForEach(film.genre_ids, id: \.self){
                            genre in
                            if(genre == self.idGenre){
                                NavigationLink(destination: FilmDetails(id: film.id)){
                                    HStack{
                                        AsyncImage(url: URL(string: film.get_poster()))
                                            .frame(width: 154, height: 235)
                                        VStack{
                                            Text(film.original_title)
                                                .font(.headline)
                                                .frame(width: 175, height: 75)
                                            
                                            Text(String(format: "%.1f", film.getStars()) + "/5 ⭐")
                                            
                                            Text(film.overview)
                                                .frame(width: 200, height: 130)
                                        }
                                    }
                                    .padding()
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
                filmListByGenre = await apiController.fetch()
            }
        }
    }
}

struct FilmListByGenre_Previews: PreviewProvider {
    static var previews: some View {
        FilmListByGenre(idGenre: 1, nameGenre: "Test")
    }
}

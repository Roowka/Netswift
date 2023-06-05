//
//  FilmMenuGenre.swift
//  TP1
//
//  Created by digital on 23/05/2023.
//

import SwiftUI

struct FilmMenuGenre: View {
    
    @State var filmListGenre: FilmGenre? = nil
    @StateObject private var apiController = FilmMenuGenreController()
    
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
                filmListGenre = await apiController.fetch()
            }
        }
    }
}

struct FilmMenuGenre_Previews: PreviewProvider {
    static var previews: some View {
        FilmMenuGenre()
    }
}

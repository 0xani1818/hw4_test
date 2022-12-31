//
//  Detail.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/6.
//

import SwiftUI

struct Detail: View {
    //@State private var isSharePresented: Bool = false
        var movie: Movie
        @State private var scale: CGFloat = 1
        @State private var newScale: CGFloat = 1
        @State private var isSharePresented: Bool = false
    var body: some View {
       // GeometryReader { geometry in
      
        VStack{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2\(movie.backdrop_path ?? "")")!){ image in
                image
                    .resizable()
            } placeholder: {
                Image("icon")
                    .resizable()
            }
            .scaledToFit()
            .frame(width: 300, height: 300)
//                .frame(width: geometry.size.width, height:geometry.size.width / 4 * 3)
                
            List{
                Section(header: Text("電影名稱")) {
                                   Text(movie.title + "（\(movie.title)）")
                }
                Section(header: Text("上映日期")) {
                                   Text(movie.release_date)
                }
                Section(header: Text("概要")) {
                                    Text(movie.overview)
                }
            }
            .navigationTitle(Text(movie.title))
            .listStyle(GroupedListStyle())
            .animation(.linear(duration:1.3))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.isSharePresented = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }.sheet(isPresented: $isSharePresented, onDismiss: {
                print("Dismiss")
            }, content: {
                ActivityViewController(activityItems: [URL(string: "https://www.themoviedb.org/movie/\(movie.id)")!])
            })
            )
        }
        //}
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(movie:.preview)
    }
}

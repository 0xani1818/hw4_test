//
//  NowPlaying.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/14.
//

import SwiftUI

struct NowPlaying: View {
    @State private var movies = [Movie]()
    var body: some View {
        NavigationView{
            List{
                ForEach(movies, id:\.id ) { movie in
                    NavigationLink{
                       Detail(movie: movie)
                    } label:{
                        MovieRow(movie: movie)
                    }
                }
            }
            .onAppear{
                fetchplaying()
            }.navigationTitle(Text("上映中"))
        }
    }
    
    func fetchplaying(){
        let urlStr = "https://api.themoviedb.org/3/movie/now_playing?api_key=fdcacafe0617aa0576fb8b9c2b754642&language=zh-TW&page=1&region=tw"
        if let url = URL(string: urlStr){
            URLSession.shared.dataTask(with: url){ (data, response, error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data,
                   let MovieResults = try? decoder.decode(MovieResult.self, from: data) {
                    movies = MovieResults.results
                }
                else {
                    print("error")
                }
            }.resume()
        }
    }
}

struct NowPlaying_Previews: PreviewProvider {
    static var previews: some View {
        NowPlaying()
    }
}

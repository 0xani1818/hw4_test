//
//  TopRated.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/14.
//

import SwiftUI

struct TopRated: View {
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
                fetchrated()
            }.navigationTitle(Text("評分最高"))
        }
    }
    
    func fetchrated(){
        let urlStr = "https://api.themoviedb.org/3/movie/top_rated?api_key=fdcacafe0617aa0576fb8b9c2b754642&language=en-US&page=1"
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

struct TopRated_Previews: PreviewProvider {
    static var previews: some View {
        TopRated()
    }
}

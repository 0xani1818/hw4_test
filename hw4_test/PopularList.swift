//
//  PopularList.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/7.
//

import SwiftUI




struct PopularList: View {
    @State private var movies = [Movie]()
    @ObservedObject var user = account()
    @State private var userImage = Image("")
    @Binding  var username : String
    @State private var create:Bool = false
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
                fetchPopular()
            }.navigationTitle(Text("熱門電影"))
                .navigationBarItems(trailing: NavigationLink(
                    destination: FbLogin(),
                    label: {
                        if (username == ""){
                            Image(systemName: "person")
                            .resizable()
                            .frame(width: 30, height: 30)}
                        else{
                                Text("\(username)")
                            }
                        
                    }))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func fetchPopular(){
        let urlStr = "https://api.themoviedb.org/3/movie/popular?api_key=fdcacafe0617aa0576fb8b9c2b754642&language=zh-TW&page=1"
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

struct PopularList_Previews: PreviewProvider {
    static var previews: some View {
        PopularList( username : .constant(""))
    }
}


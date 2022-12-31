//
//  MovieRow.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/6.
//

import SwiftUI

struct MovieRow: View {
    var movie:Movie
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2\(movie.backdrop_path ?? "")")!){ phase in
                        if let image = phase.image {
                            image
                                .resizable()
                        } else if phase.error != nil {
                            Image("icon")
                                .resizable()
                        } else {
                            Color.gray
                        }
                    }
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            VStack(alignment: .leading) {
                           Text(movie.title)
                    .font(.system(size: 20))
                               .bold()
                           Text("\n上映日期：" + movie.release_date)
                    .font(.system(size: 15))
                       }
        }
    }
}



struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie:.preview)
    }
}
//https://image.tmdb.org/t/p/w600_and_h900_bestv2/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg

//movie: Movie(id: 436270, backdrop_path: URL(string: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/bQXAqRx2Fgc46uCVWgoPz5L5Dtr.jpg")!, title: "title", overview: "test", release_date: "2022-11-12")

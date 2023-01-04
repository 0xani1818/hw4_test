//
//  Search.swift
//  hw4_test
//
//  Created by Yu Zhi on 2023/1/4.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var fetcher: ItunesDataFetcher
    @State private var searchText = ""
    @State private var showError = false
    @State private var error: Error?
    
    var searchResult: [Movie] {
        if searchText.isEmpty {
            return fetcher.items
        } else {
            return fetcher.items.filter {
                $0.title.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResult, id: \.id) { item in
                    ItemRow(movie: item)
                }
            }
        }.searchable(text: $searchText)
        .alert(error?.localizedDescription ?? "",isPresented: $showError, actions: {})
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}

struct ItemRow: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
            
        }
    }
}

//
//  SearchBar.swift
//  hw4_test
//
//  Created by Yu Zhi on 2023/1/1.
//

import SwiftUI

struct SearchBar : UIViewRepresentable {
    @Binding var text : String
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }
    
    func makeCoordinator() -> Cordinator {
        return Cordinator(text: $text)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>)
    -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    class Cordinator : NSObject, UISearchBarDelegate {
        @Binding var text : String
        init(text : Binding<String>)
        {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    }
}

struct SearchBarView: View {
    let djs = [
        "阿凡達2",
        "黑亞當",
        "Soul",
        "Skylines",
        "Вратарь Галактики",
        "急先鋒",
        "Copper Bill",
        "Miraculous World: New York, United HeroeZ",
        "Monsters of Man",
        "The Doorman"
      ]
      //1 - search text binding
      @State private var searchTerm : String = ""
      
      var body: some View {
        NavigationView{
          List {
            //2- search bar added to the list
            SearchBar(text: $searchTerm)
            //3- filter djs based on the search term
            ForEach(self.djs.filter { self.searchTerm.isEmpty ? true : $0.contains(self.searchTerm) }, id: \.self) { name in
              Text(name)
            }
          }
          .navigationBarTitle(Text("Top 10 Movies"))
          .navigationBarTitleDisplayMode(.inline)
        }
      }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}

//
//  HomePage.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/15.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        TabView{
            PopularList(username : .constant(""))
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("熱門")
                }
            NowPlaying()
                .tabItem {
                    Image(systemName: "play.fill")
                    Text("上映中")
                }
            UpComingView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("即將上映")
                }
            TopRated()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("評分最高")
                }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

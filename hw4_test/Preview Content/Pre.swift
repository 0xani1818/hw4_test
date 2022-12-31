//
//  Pre.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/6.
//

import UIKit
import Foundation



extension Movie{
    static var preview: Self {
        let data = NSDataAsset(name: "movie_json")! .data
        let decoder = JSONDecoder()
        let movieResult = try! decoder.decode(MovieResult.self, from:data)
        return movieResult.results[0]

    }
    
}

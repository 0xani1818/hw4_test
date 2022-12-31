//
//  login.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/27.
//


import Foundation
import SwiftUI

class  Login:ObservableObject {
    @Published var token :String = ""
    @Published var login :String = ""
}

enum ActiveAlert {
    case net, login
}

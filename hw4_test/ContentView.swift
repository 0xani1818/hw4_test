//
//  ContentView.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/6.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct MovieResult: Codable,Hashable{
    let results:[Movie]
}

struct Movie:Codable, Hashable{
    let id:Int
    let backdrop_path:String?
    let title:String
    let overview:String
    let release_date:String
}

let movietype: [String] = ["熱門電影", "上映中", "即將上映", "評分最高"]

struct CreateUser: Encodable {
    let user:[userInfo]
}

struct userInfo: Encodable{
    let login:String
    let email:String
    let password:String
}


struct User: Identifiable, Codable {
    var id = UUID()
    var name: String = ""
    var imageName: String = ""
}

struct  CreatedSessionBody:Codable {
    public let user:SessionUser
}

struct SessionUser :Codable{
    public let login: String
    public let password: String
}

struct  CreateSessionResponse:Codable {
    public let Token: String
    public let login: String
    public let email:String
    
    enum CodingKeys:String,CodingKey{
        case Token = "User-Token"
        case login
        case email
    }
}

struct  CreatedUsersBody:Codable {
    public let user:CreatedUsers
}

struct CreatedUsers:Codable {
    let login: String
    let email: String
    let password: String
}

struct  CreatedUsersResponse:Codable {
    let Token: String
    let login: String
    enum CodingKeys:String,CodingKey{
        case Token = "User-Token"
        case login
    }
}

class UserData: ObservableObject {
    @AppStorage ("user") var userData: Data?
    
    @Published var user = User() {
        didSet {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(user)
                userData = data
            } catch {
                
            }
        }
    }
    
    init() {
        if let userData = userData {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode(User.self, from: userData) {
                user = decodedData
            }
        }
    }
}

class account : ObservableObject{
    @Published var name = ""
    var email = ""
    var password = ""
}

//
//  SignIn.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/27.
//

import SwiftUI
import UIKit
import AlertX
import FacebookLogin


struct SignInView: View {
    @EnvironmentObject var loginData:Login
    @State var email:String=""
    @State var password:String=""
    @State private var showingAlert = false
    @State private var activeAlert : ActiveAlert = .login
    var textFieldBorder: some View {
           RoundedRectangle(cornerRadius: 20)
               .stroke(Color.blue, lineWidth: 2)
       }
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Sign in")
                    .font(.title)
                    .frame(alignment: .center)
                TextField("email",text: $email)
                    .padding()
                    .overlay(textFieldBorder)
                    .padding()
                SecureField("password",text: $password)
                    .padding()
                    .overlay(textFieldBorder)
                    .padding()
                
                HStack(spacing:70) {
                    NavigationLink(
                        destination: SignUpView(),
                        label: {
                            Text("Create account")
                        })
                    Button(action: {
                        
                        let url = URL(string: "https://favqs.com/api/session")!
                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        request.setValue("Token token=\"bdb45b3357e3021ceef7d1319ddd5b40\"", forHTTPHeaderField: "Authorization")
                        let encoder = JSONEncoder()
                        let user = CreatedSessionBody(user:SessionUser(login: email, password: password))
                        let data = try? encoder.encode(user)
                        request.httpBody = data
                        print("user=\(user)")
                        URLSession.shared.dataTask(with: request) { data, response, error in
                            if let data = data{
                                do{
                                    let content = String(data: data, encoding: .utf8)
                                    print("content=\(String(describing: content))")
                                    let decoder = JSONDecoder()
                                    let createSessionResponse = try decoder.decode(CreateSessionResponse.self, from: data)
                                    print(createSessionResponse)
                                    loginData.token = createSessionResponse.Token
                                    loginData.login=createSessionResponse.login
                                }catch{
                                    print(error)
                                    showingAlert = true
                                    activeAlert = .login
                                }
                            }else if error != nil{
                                print("NET")
                                showingAlert = true
                                activeAlert = .net
                            }
                        }.resume()
                    }, label: {
                        Text("Sign In")
                    })
                    .alertX(isPresented: $showingAlert, content: { () -> AlertX in
                        switch activeAlert{
                        case .login:
                            return AlertX(title: Text("Incorrect username or password"), theme: .wine(withTransparency: true, roundedCorners: true),
                                          animation: .zoomEffect())
                        case .net:
                            return AlertX(title: Text("No Connection"), theme: .wine(withTransparency: true, roundedCorners: true),
                                          animation: .zoomEffect())
                        }
                    })
                    .font(.system(size: 16))
                    .frame(width: 100, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .padding(2)
                    .background(Color.blue)
                    .cornerRadius(5)

                }
                
                Button {
                    let manager = LoginManager()
                    manager.logIn { result in
                        switch result {
                        case .success(granted: let granted, declined: let declined, token: let token):
                            print("success")
                        case .cancelled:
                            print("cancelled")
                        case .failed(_):
                            print("failed")
                        }
                    }
                } label: {
                    LoginButton()
                        .frame(width: 300, height: 40)
                }
            }.offset(y: -150.0)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


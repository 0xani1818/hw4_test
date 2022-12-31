//
//  FbLogin.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/11.
//

import SwiftUI
import FacebookLogin
struct FbLogin: View {
    @State var username = ""
    @State var email = ""
    @EnvironmentObject var loginData:Login
    
    //@Binding var create:Bool
    var body: some View {
        
        Text(loginData.login).padding()
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
                    .frame(width: 100, height: 40)
            }
        
        
    }
}


struct FbLogin_Previews: PreviewProvider {
    static var previews: some View {
        FbLogin()
    }
}

struct LoginButton: UIViewRepresentable {
    func makeUIView(context: Context) -> FBLoginButton {
        FBLoginButton()
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
        
    }
    
    typealias UIViewType = FBLoginButton
    
    
}

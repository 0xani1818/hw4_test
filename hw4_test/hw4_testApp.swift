//
//  hw4_testApp.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/6.
//

import SwiftUI
import FacebookCore

@main
struct hw4_testApp: App {
    @StateObject private var loginData = Login()
    init() {
            ApplicationDelegate.shared.application(UIApplication.shared)
        }
    
    var body: some Scene {
        WindowGroup {
            if loginData.token == ""
            {
                SignInView().environmentObject(loginData)
                    .onOpenURL { url in
                        ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                    }//在遵從 protocol App 的型別裡加入 onOpenURL modifier，如果有切換到 FB App，再從 FB App 切換回我們的 App 時會呼叫 onOpenURL
                    
            }else{
                HomePage().environmentObject(loginData)
                    .onOpenURL { url in
                        ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                    }//在遵從 protocol App 的型別裡加入 onOpenURL modifier，如果有切換到 FB App，再從 FB App 切換回我們的 App 時會呼叫 onOpenURL
                  
            }
            //PopularList(username: .constant("Annie"))
        }
    }
}

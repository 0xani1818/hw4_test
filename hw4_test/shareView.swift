//
//  shareView.swift
//  hw4_test
//
//  Created by Yu Zhi on 2022/12/15.
//

import UIKit
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}

struct shareView: View {
    @State private var isSharePresented: Bool = false
    
    var body: some View {
        Button("Share app") {
            self.isSharePresented = true
        }
        .sheet(isPresented: $isSharePresented, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [URL(string: "https://www.apple.com")!])
        })
    }
}

struct shareView_Previews: PreviewProvider {
    static var previews: some View {
        shareView()
    }
}

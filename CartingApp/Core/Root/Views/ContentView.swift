//
//  ContentView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group{
            if viewModel.userSession != nil{
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                Button {
                    AuthService.shared.signOut()
                } label:{
                    Text("Sign Out")
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview("English") {
    ContentView()
}

#Preview("Bulgarian") {
    ContentView()
        .environment(\.locale, Locale(identifier: "bg"))
}


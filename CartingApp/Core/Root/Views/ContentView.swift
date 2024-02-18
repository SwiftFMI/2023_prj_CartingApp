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
                CartingTabView()
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


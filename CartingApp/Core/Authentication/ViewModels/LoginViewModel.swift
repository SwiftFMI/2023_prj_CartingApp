//
//  LoginViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    @MainActor
    func loginUser() async throws{
        try await AuthService.shared.loginUser(
            withEmail: email,
            password: password
        )
    }
}

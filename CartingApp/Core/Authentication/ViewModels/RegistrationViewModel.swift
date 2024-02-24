//
//  RegistrationViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegistrationViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var nickname = ""
    @Published var fullname = ""
    
    @MainActor
    func createUser() async throws{
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullname,
            nickname: nickname
        )
    }
}

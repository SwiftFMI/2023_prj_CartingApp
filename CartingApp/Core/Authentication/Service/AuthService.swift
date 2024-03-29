//
//  AuthService.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseFirestore

class AuthService{
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func loginUser(withEmail email: String, password: String ) async throws{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await UserService.shared.fetchCurrentUser()
    }
    @MainActor
    func createUser(withEmail email: String, password: String, fullname:String, nickname:String ) async throws{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(id: result.user.uid, withEmail: email, fullname: fullname, nickname: nickname)
    }
    
    func signOut(){
        try? Auth.auth().signOut() // sign out from firebase
        self.userSession = nil // sign out from session locally
        UserService.shared.reset() // sets current user to nil
    }
    
    @MainActor
    private func uploadUserData(
        id: String,
        withEmail email: String,
        fullname:String,
        nickname:String
    ) async throws{
        let user = User(id: id, fullname: fullname, email: email, nickname: nickname, bestTime: nil)
        guard let userData =  try? Firestore.Encoder().encode(user) else {return}
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}

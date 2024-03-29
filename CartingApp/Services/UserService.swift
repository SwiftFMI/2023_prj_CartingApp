//
//  UserService.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserService {
    @Published var currentUser: User?
    
    static var shared = UserService()
    
    init(){
        Task { try await fetchCurrentUser()}
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    
    static func fetchUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return []}
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap({try? $0.data(as: User.self)})
        return users.filter({ $0.id != currentUid})
    }
    
    func reset(){
        self.currentUser = nil
    }
    
    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws{
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        self.currentUser?.profileImageUrl = imageUrl
        
    }
    
    @MainActor
    func updateUserNickname(newNickname: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "nickname": newNickname,
        ])
        try await fetchCurrentUser()
    }

    func sendPasswordResetEmail(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}

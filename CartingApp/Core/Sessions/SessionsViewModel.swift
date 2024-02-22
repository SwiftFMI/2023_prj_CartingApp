//
//  SessionsViewModel.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 21.02.24.
//

import Foundation

class SessionsViewModel: ObservableObject{
    @Published var sessions = [Session]()
    @Published var lastSession : Session?
    
    init(){
        Task{try await getUserSessions()}
    }
    
    @MainActor
    private func getUserSessions() async throws {
        if((UserService.shared.currentUser) != nil){
            print(UserService.shared.currentUser?.id ?? "wrong")
            self.sessions = try await SessionsService().fetchUserSessions(userId: UserService.shared.currentUser?.id ?? "")
            print(sessions)
        }
    }
    
    
    @MainActor
    private func getLastUserSession() async throws {
        if((UserService.shared.currentUser) != nil){
            print(UserService.shared.currentUser ?? "wrong")
            self.lastSession = try await SessionsService().fetchLastUserSession(userId: UserService.shared.currentUser?.id ?? "")
            print(lastSession as Any)
        }
    }
}

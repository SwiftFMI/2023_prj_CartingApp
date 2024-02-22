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
    @Published var sessionElements = [SessionElement]()
    @Published var currentUser : User?
    
    init(){
        Task{try await getUserSessions()}
    }
    
    @MainActor
    private func getUserSessions() async throws {
        if((UserService.shared.currentUser) != nil){
            self.currentUser = UserService.shared.currentUser
            self.sessions = try await SessionsService().fetchUserSessions(userId: UserService.shared.currentUser?.id ?? "")
            for session in sessions{
                try await getSessionBestLap(session: session)
            }
        }
    }
    
    
    @MainActor
    private func getLastUserSession() async throws {
        if((UserService.shared.currentUser) != nil){
            self.lastSession = try await SessionsService().fetchLastUserSession(userId: UserService.shared.currentUser?.id ?? "")
        }
    }
    
    @MainActor
    private func getSessionBestLap(session: Session) async throws {
        if((UserService.shared.currentUser) != nil){
            let laps = try await SessionsService().fetchUserBestLapInSession(userId: UserService.shared.currentUser?.id ?? "", sessionId: session.id)
            if(!laps.isEmpty){
                let bestLap =  laps.first(where: {$0.userId == UserService.shared.currentUser?.id ?? ""})
                let newSession = SessionElement(startTime:session.startTime,id: session.id,username:UserService.shared.currentUser?.fullname ?? "", lapTime: bestLap?.lapTime ?? 0)
                sessionElements.append(newSession)
            }
        }
    }
//    
//    @MainActor
//    private func getBestUserLapInSession(laps: [Lap]) async throws -> Lap{
//        if(laps.isEmpty){
//            return laps.first(where: {$0.userId == UserService.shared.currentUser?.id ?? ""})
//        }
//    }
        
}

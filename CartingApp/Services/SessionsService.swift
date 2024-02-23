//
//  SessionsService.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation
import FirebaseFirestore

class SessionsService {
    static let shared = SessionsService()

    func fetchUserSessions(userId: String) async throws -> [Session] {
        let snapshot = try await Firestore.firestore()
            .collection("sessions")
            .whereField("participants", arrayContains: userId)
            .order(by: "startTime", descending: true)
            .getDocuments()
        
        let sessions = snapshot
        .documents
        .compactMap({try? $0.data(as: Session.self)})
        
        return sessions
    }

    func fetchLastUserSession(userId: String) async throws -> Session? {
        let snapshot = try await Firestore.firestore()
            .collection("sessions")
            .whereField("participants", arrayContains: userId)
            .order(by: "startTime", descending: true)
            .limit(to: 1)
            .getDocuments()
        
        let session = snapshot
        .documents
        .compactMap({try? $0.data(as: Session.self)})
        .first

        return session
    }
    
    func fetchUserBestLapInSession(userId: String, sessionId: String) async throws -> [Lap]{
        let lapsSnapshot = try await Firestore.firestore()
            .collection("sessions")
            .document(sessionId)
            .collection("laps")
            .order(by: "lapTime", descending: false)
            .getDocuments()

        let lapsData = lapsSnapshot.documents.compactMap({try? $0.data(as: Lap.self)})
        return lapsData
    }
}

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

    func fetchUserSessionsWithBestLap(userId: String) async throws -> [(bestTime: Double?, session: Session)] {
        let db = Firestore.firestore()
        let sessionsSnapshot = try await db.collection("sessions")
            .whereField("participants", arrayContains: userId)
            .order(by: "startTime", descending: true)
            .getDocuments()

        var sessionsWithBestLap: [(bestTime: Double?, session: Session)] = []

        guard !sessionsSnapshot.documents.isEmpty else {
            return []
        }

        for sessionDocument in sessionsSnapshot.documents {
            guard let session = try? sessionDocument.data(as: Session.self) else { continue }
            let bestLap = try await LapService.shared
                .fetchBestLapInSessionForSpecificUser(sessionId: sessionDocument.documentID, userId: userId)

            sessionsWithBestLap.append((bestTime: bestLap?.lapTime, session: session))
        }

        return sessionsWithBestLap
    }

    func fetchLastUserSessionWithBestLap(userId: String) async throws -> (bestTime: Double?, session: Session)? {
        let db = Firestore.firestore()
        let sessionSnapshot = try await db.collection("sessions")
            .whereField("participants", arrayContains: userId)
            .order(by: "startTime", descending: true)
            .limit(to: 1)
            .getDocuments()

        guard let sessionDocument = sessionSnapshot.documents.first,
              let session = try? sessionDocument.data(as: Session.self) else {
            return nil
        }

        let bestLap = try await LapService.shared
            .fetchBestLapInSessionForSpecificUser(sessionId: sessionDocument.documentID, userId: userId)

        return (bestTime: bestLap?.lapTime, session: session)
    }
}


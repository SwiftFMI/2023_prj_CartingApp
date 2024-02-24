//
//  LapService.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 23.02.24.
//

import Foundation
import FirebaseFirestore

class LapService {
    static let shared = LapService()
    
    func fetchLapsInSession(sessionId: String) async throws -> [Lap] {
        let snapshot = try await Firestore.firestore()
            .collection("sessions")
            .document(sessionId)
            .collection("laps")
            .getDocuments()
        
        let laps = snapshot
            .documents
            .compactMap({try? $0.data(as: Lap.self)})
        
        return laps
    }
    
    func fetchLapsInSessionForSpecificUser(sessionId: String, userId: String) async throws -> [Lap] {
        let snapshot = try await Firestore.firestore()
            .collection("sessions")
            .document(sessionId)
            .collection("laps")
            .whereField("userId", isEqualTo: userId)
            .getDocuments()
        
        let laps = snapshot
            .documents
            .compactMap({try? $0.data(as: Lap.self)})
        
        return laps
    }
    
    func fetchBestLapInSessionForSpecificUser(sessionId: String, userId: String) async throws -> Lap? {
        let snapshot = try await Firestore.firestore()
            .collection("sessions")
            .document(sessionId)
            .collection("laps")
            .whereField("userId", isEqualTo: userId)
            .order(by: "lapTime", descending: false)
            .limit(to: 1)
            .getDocuments()
        
        let lap = snapshot
            .documents
            .compactMap({try? $0.data(as: Lap.self)})
            .first
        
        return lap
    }
}

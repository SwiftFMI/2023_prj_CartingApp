//
//  LeaderboardService.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation
import FirebaseFirestore

class LeaderboardService {
    static let shared = LeaderboardService()

    func fetchLeaderboardForUser(userId: String) async throws -> [Int: User] {
        let db = Firestore.firestore()
        
        // Fetch the current user's best time
        let userDoc = try await db
            .collection("users")
            .document(userId)
            .getDocument()
            .data(as: User.self)
        guard let currentUserBestTime = userDoc.bestTime else {
            throw NSError(domain: "User data fetch error - probably the user doesn't have any session and doesn't have best time value", code: -1, userInfo: nil)
        }
        
        // Fetch two users with a better best time (lower value)
        let betterQuery = db.collection("users")
            .whereField("bestTime", isLessThan: currentUserBestTime)
            .order(by: "bestTime", descending: true)
            .limit(to: 2)
        
        let betterUsers = try await betterQuery.getDocuments().documents.compactMap { document -> User? in
            return try? document.data(as: User.self)
        }
        
        // Fetch two users with a worse best time (higher value)
        let worseQuery = db.collection("users")
            .whereField("bestTime", isGreaterThan: currentUserBestTime)
            .order(by: "bestTime")
            .limit(to: 2)
        
        let worseUsers = try await worseQuery.getDocuments().documents.compactMap { document -> User? in
            return try? document.data(as: User.self)
        }
        
        // Calculate current user's rank
        let rankQuery = db.collection("users")
            .whereField("bestTime", isLessThan: currentUserBestTime)
        
        let rank = try await rankQuery.getDocuments().count + 1 // Adding 1 because Firestore indices are 0-based
        
        
        // Final step: compile the results into a map
        var leaderboard: [Int: User] = [:]
        
        // Add better users
        var index = rank - betterUsers.count
        for user in betterUsers.reversed() {
            leaderboard[index] = user
            index += 1
        }
        
        // Add current user
        leaderboard[rank] = userDoc
        
        // Add users with worse best time
        index = rank + 1
        for user in worseUsers {
            leaderboard[index] = user
            index += 1
        }
        
        return leaderboard
    }
    
    // Fetch users with better times
    func fetchUsersWithBetterTimes(startingAfterDocument cursorDocument: DocumentSnapshot? = nil, bestTime: Double) async throws -> ([User], DocumentSnapshot?) {
        let db = Firestore.firestore()
        var query = db.collection("users")
            .whereField("bestTime", isLessThan: bestTime)
            .order(by: "bestTime", descending: true)
            .limit(to: 5)

        if let cursorDocument = cursorDocument {
            query = query.start(afterDocument: cursorDocument)
        }

        let snapshot = try await query.getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        let lastDocument = snapshot.documents.last
        
        return (users, lastDocument)
    }

    // Fetch users with worse times
    func fetchUsersWithWorseTimes(startingAfterDocument cursorDocument: DocumentSnapshot? = nil, worseTime: Double) async throws -> ([User], DocumentSnapshot?) {
        let db = Firestore.firestore()
        var query = db.collection("users")
            .whereField("bestTime", isGreaterThan: worseTime)
            .order(by: "bestTime")
            .limit(to: 5)

        if let cursorDocument = cursorDocument {
            query = query.start(afterDocument: cursorDocument)
        }

        let snapshot = try await query.getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        let lastDocument = snapshot.documents.last
        
        return (users, lastDocument)
    }
}

//
//  LeaderboardView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation
import SwiftUI
import Firebase

struct LeaderboardView: View {
    let currentUser: User
    @State private var leaderboard: [Int: User] = [:]
    @State private var lastBetterDocument: DocumentSnapshot?
    @State private var lastWorseDocument: DocumentSnapshot?
    
    var body: some View {
        VStack {
            Button("Load More Better") {
                loadMoreWorseTimes()
            }
            ForEach(leaderboard.sorted(by: { $0.key < $1.key }), id: \.key) { rank, user in
                Text("\(rank). \(user.fullname) - \(user.bestTime ?? 0, specifier: "%.2f")")
            }
            
            VStack {
                Button("Load Leaderboard") {
                    fetchInitialLeaderboard()
                }
                
                Button("Load More Worse") {
                    loadMoreWorseTimes()
                }
            }
        }
    }
    
    // Initial fetch for the current user's leaderboard position
    func fetchInitialLeaderboard() {
        Task {
            do {
                let leaderboardData = try await LeaderboardService.shared.fetchLeaderboardForUser(userId: currentUser.id)
                self.leaderboard = leaderboardData
            } catch {
                print("Error fetching leaderboard: \(error)")
            }
        }
    }
    
    // Load more users with better (lower) best times
    func loadMoreBetterTimes() {
        guard let bestTime = leaderboard.values.min(by: { $0.bestTime ?? Double.infinity < $1.bestTime ?? Double.infinity })?.bestTime else { return }
        
        Task {
            do {
                let (users, lastDocument) = try await LeaderboardService.shared.fetchUsersWithBetterTimes(startingAfterDocument: lastBetterDocument, bestTime: bestTime)
                lastBetterDocument = lastDocument
                for user in users {
                    // todo
                }
                // Update leaderboard state
            } catch {
                print("Error loading more better times: \(error)")
            }
        }
    }
    
    // Load more users with worse (higher) best times
    func loadMoreWorseTimes() {
        guard let worseTime = leaderboard.values.max(by: { $0.bestTime ?? 0 < $1.bestTime ?? 0 })?.bestTime else { return }
        
        Task {
            do {
                let (users, lastDocument) = try await LeaderboardService.shared.fetchUsersWithWorseTimes(startingAfterDocument: lastWorseDocument, worseTime: worseTime)
                lastWorseDocument = lastDocument
                for user in users {
                    // todo
                }
                // Update leaderboard state
            } catch {
                print("Error loading more worse times: \(error)")
            }
        }
    }
}

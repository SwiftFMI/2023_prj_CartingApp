//
//  LeaderboardViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 23.02.24.
//

import FirebaseFirestore
import Combine

class LeaderboardViewModel: ObservableObject {
    @Published var leaderboard: [Int: User] = [:]
    @Published var isLoading: Bool = false
    private var lastBetterDocument: DocumentSnapshot?
    private var lastWorseDocument: DocumentSnapshot?

    func fetchInitialLeaderboard(userId: String) {
        isLoading = true
        Task {
            do {
                let leaderboardData = try await LeaderboardService.shared
                    .fetchLeaderboardForUser(userId: userId)
                DispatchQueue.main.async {
                    self.leaderboard = leaderboardData
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error fetching initial leaderboard: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadMoreBetterTimes(currentUserId: String) {
        guard !isLoading, let currentUserBestTime = leaderboard.values
            .first(where: { $0.id == currentUserId })?.bestTime else { return }
        
        isLoading = true
        Task {
            do {
                let (users, lastDocument) = try await LeaderboardService.shared
                    .fetchUsersWithBetterTimes(startingAfterDocument: lastBetterDocument, bestTime: currentUserBestTime)
                DispatchQueue.main.async {
                    // Update the last document for pagination
                    self.lastBetterDocument = lastDocument
                    
                    // Calculate new ranks for fetched users and merge them into the existing leaderboard
                    let newEntriesStartIndex = self.leaderboard.keys.min() ?? 1 - users.count
                    var newEntries = [Int: User]()
                    
                    for (offset, user) in users.enumerated() {
                        newEntries[newEntriesStartIndex + offset] = user
                    }
                    
                    self.leaderboard.merge(newEntries) { (_, new) in new }
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error loading more better times: \(error.localizedDescription)")
                }
            }
        }
    }

    func loadMoreWorseTimes(currentUserId: String) {
        guard !isLoading, let currentUserBestTime = leaderboard.values
            .first(where: { $0.id == currentUserId })?.bestTime else { return }
        
        isLoading = true
        Task {
            do {
                let (users, lastDocument) = try await LeaderboardService.shared
                    .fetchUsersWithWorseTimes(startingAfterDocument: lastWorseDocument, worseTime: currentUserBestTime)
                DispatchQueue.main.async {
                    // Update the last document for pagination
                    self.lastWorseDocument = lastDocument
                    
                    // Calculate new ranks for fetched users and merge them into the existing leaderboard
                    let newEntriesStartIndex = self.leaderboard.keys.max() ?? 0 + 1
                    var newEntries = [Int: User]()
                    
                    for (offset, user) in users.enumerated() {
                        newEntries[newEntriesStartIndex + offset] = user
                    }
                    
                    self.leaderboard.merge(newEntries) { (_, new) in new }
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error loading more worse times: \(error.localizedDescription)")
                }
            }
        }
    }
}


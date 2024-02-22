//
//  LeaderboardViewModel.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 22.02.24.
//

import Foundation

class LeaderboardViewModel: ObservableObject{
    @Published var leaderboard:[Int: User]
    
//    init(){
//        Task{try await fetchLeaderboardData()}
//    }
    
    @MainActor
    private func fetchLeaderboardData () async throws{
        self.leaderboard = try await LeaderboardService.shared.fetchLeaderboardForUser(userId: UserService.shared.currentUser?.id ?? "")
    }
}

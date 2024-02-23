//
//  SessionsViewModel.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 21.02.24.
//

import Foundation
import FirebaseFirestore

class SessionsViewModel: ObservableObject {
    @Published var lastSessionWithBestLap: (bestTime: Double?, session: Session)?
    @Published var allSessionsWithBestLap: [(bestTime: Double?, session: Session)] = []
    @Published var isLoading: Bool = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    func fetchLastSessionWithBestLap() {
        isLoading = true
        Task {
            do {
                let result = try await SessionsService.shared
                    .fetchLastUserSessionWithBestLap(userId: userId)
                DispatchQueue.main.async {
                    self.lastSessionWithBestLap = result
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error fetching last session: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchAllSessionsWithBestLap() {
        isLoading = true
        Task {
            do {
                let results = try await SessionsService.shared
                    .fetchUserSessionsWithBestLap(userId: userId)
                DispatchQueue.main.async {
                    self.allSessionsWithBestLap = results
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print("Error fetching all sessions: \(error.localizedDescription)")
                }
            }
        }
    }
}

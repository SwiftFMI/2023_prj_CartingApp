//
//  LapsViewModel.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 23.02.24.
//

import Foundation


class LapsViewModel: ObservableObject {
    @Published var currentSessionsUserLaps: [Lap] = []
    @Published var isLoading: Bool = false
    
    private let userId: String
    private let sessionId: String
    
    init(userId: String,sesionId: String) {
        self.userId = userId
        self.sessionId = sesionId
    }
    
    @MainActor
    private func fetchLapsForUser(){
        isLoading = true
        Task{
            do{
                let result = try await LapService.shared.fetchLapsInSessionForSpecificUser(sessionId: self.sessionId, userId: self.userId)
                DispatchQueue.main.async {
                    self.currentSessionsUserLaps = result
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
}

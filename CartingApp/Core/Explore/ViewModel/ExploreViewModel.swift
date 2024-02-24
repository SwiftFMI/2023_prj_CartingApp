//
//  ExploreViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation


class ExploreViewModel: ObservableObject{
    @Published var users = [User]()
    
    init() {
        Task {try await fetchUsers()}
    }
    
    @MainActor
    private func fetchUsers() async throws{
        self.users = try await UserService.fetchUsers()
    }
}

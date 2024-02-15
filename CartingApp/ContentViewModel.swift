//
//  ContentViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import Combine
import FirebaseAuth


class ContentViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    private var cancelables = Set <AnyCancellable>()
    
    init(){
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        AuthService.shared.$userSession.sink{ [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancelables)
    }
}

//
//  UserContentView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation
import SwiftUI

struct UserContentView: View {
    let user: User
    
    var body: some View {
        ScrollView {
            VStack {
                LastSessionView(viewModel: SessionsViewModel(userId: user.id))
                LeaderboardView(currentUser: user)
            }
        } 
     }
}

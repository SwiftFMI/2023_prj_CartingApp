//
//  LeaderboardView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation
import SwiftUI

struct LeaderboardView: View {
    @StateObject var viewModel = LeaderboardViewModel()
    let currentUser: User
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all) // Set the background to white
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            leaderboardHeader
                            Divider()
                            if viewModel.leaderboard.isEmpty {
                                // Display a message when there are no entries
                                Text("Don't have any sessions yet.\nNeed to start racing to appear on the leaderboard!")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .foregroundColor(.gray)
                            } else {
                                leaderboardContent
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding()
                }
            }
            .onAppear {
                viewModel.fetchInitialLeaderboard(userId: currentUser.id)
            }
        }
    }
    
    var leaderboardContent: some View {
        ForEach(Array(viewModel.leaderboard.keys.sorted()), id: \.self) { rank in
            if let user = viewModel.leaderboard[rank] {
                LeaderboardEntryView(position: rank,
                                     user: user,
                                     isCurrentUser: user.id == currentUser.id)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    
    var leaderboardHeader: some View {
        HStack(alignment: .center) {
            Image(systemName: "list.number")
                .font(.title2)
                .frame(alignment: .center)
            Text("Leaderboard")
                .font(.title2)
                .fontWeight(.bold)
                .frame(alignment: .center)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 10)
    }
}

struct LeaderboardEntryView: View {
    let position: Int
    let user: User
    var isCurrentUser: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            CircleProfileImageView(user: user)
                .frame(width: StandardImage.width, height: StandardImage.height)
            
            // Nickname and Best Time
            VStack(alignment: .leading, spacing: 4) {
                Text(user.nickname)
                    .bold()
                    .font(.system(size: 14))
                if let bestLapTime = user.bestTime {
                    Text(String(format: "%.2f", bestLapTime))
                        .font(.system(size: 14))
                } else {
                    Text("N/A")
                        .font(.system(size: 14))
                }
            }
            
            Spacer()
            
            // Rank
            Text("#\(position)")
                .bold()
                .font(.system(size: 14))
                .padding(6)
                .background(isCurrentUser ? Color.blue.opacity(0.2) : Color.clear)
                .clipShape(Circle())
        }
        .padding(8)
        .background(isCurrentUser ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
        .cornerRadius(5)
    }
}

//
//  AllSessionsView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 23.02.24.
//

import Foundation
import SwiftUI

struct AllSessionsView: View {
    @ObservedObject var viewModel: SessionsViewModel
    
    var SessionsContent: some View {
                ForEach(viewModel.allSessionsWithBestLap, id: \.session.id) { sessionWithLap in
                    NavigationLink{
                        LapsView(userId: UserService.shared.currentUser?.id ?? "", sessionId: sessionWithLap.session.id)
                    }
                label:{
                    SessionEntryView(session: sessionWithLap.session, bestLapTime: sessionWithLap.bestTime)
                        .padding(.horizontal)
                        .frame(minWidth: 350, alignment: .center)
                }
                }
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center) {
                                Image(systemName: "flag.checkered.2.crossed")
                                    .font(.title2)
                                    .frame(alignment: .center)
                                Text("Sessions")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                            Divider()
                            if viewModel.allSessionsWithBestLap.isEmpty {
                                Text("Don't have any sessions yet")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .foregroundColor(.gray)
                            } else {
                                SessionsContent
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
                viewModel.fetchAllSessionsWithBestLap()
            }
        }
    }
}

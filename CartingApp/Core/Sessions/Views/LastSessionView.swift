//
//  LastSessionView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 23.02.24.
//

import Foundation
import SwiftUI

struct LastSessionView: View {
    @StateObject var viewModel: SessionsViewModel
    @State private var showAllSessions = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        ScrollView {
                            VStack(alignment: .center, spacing: 10) {
                                headerView
                                Divider()
                                if let lastSession = viewModel.lastSessionWithBestLap {
                                    SessionEntryView(session: lastSession.session, bestLapTime: lastSession.bestTime)
                                    Button("See all sessions") {
                                        showAllSessions = true
                                    }
                                    .background(
                                        NavigationLink(destination: AllSessionsView(viewModel: viewModel), isActive: $showAllSessions) {
                                            EmptyView()
                                        }
                                            .hidden()
                                    )
                                } else {
                                    Text("No sessions available")
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchLastSessionWithBestLap()
                }
                .frame(height: 210)
            }
        }
    }
        var headerView: some View{
            HStack(alignment: .center) {
                Image(systemName: "flag.checkered.2.crossed")
                    .font(.title2)
                    .frame(alignment: .center)
                Text("Last Session")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(alignment: .center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
        }

    }

//            VStack {
//                if viewModel.isLoading {
//                    ProgressView()
//                } else if let lastSession = viewModel.lastSessionWithBestLap {
//                    SessionEntryView(session: lastSession.session, bestLapTime: lastSession.bestTime)
//                    Button("See all sessions") {
//                        showAllSessions = true
//                    }
//                    .background(
//                        NavigationLink(destination: AllSessionsView(viewModel: viewModel), isActive: $showAllSessions) {
//                            EmptyView()
//                        }
//                        .hidden()
//                    )
//                } else {
//                    Text("No sessions available")
//                }
//            }
//            .navigationTitle("Last Session")
//            .onAppear {
//                viewModel.fetchLastSessionWithBestLap()
//            }

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
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let lastSession = viewModel.lastSessionWithBestLap {
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
            .navigationTitle("Last Session")
            .onAppear {
                viewModel.fetchLastSessionWithBestLap()
            }
        }
    }
}

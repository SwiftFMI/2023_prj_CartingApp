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
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.allSessionsWithBestLap, id: \.session.id) { sessionWithLap in
                    SessionEntryView(session: sessionWithLap.session, bestLapTime: sessionWithLap.bestTime)
                }
            }
        }
        .onAppear {
            viewModel.fetchAllSessionsWithBestLap()
        }
    }
}

//
//  SessionEntryView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 23.02.24.
//

import Foundation
import SwiftUI

struct SessionEntryView: View {
    let session: Session
    let bestLapTime: Double?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Session on \(session.startTime, formatter: itemFormatter)")
            if let bestTime = bestLapTime {
                Text("Best Lap: \(bestTime, specifier: "%.2f") seconds")
            } else {
                Text("No laps recorded")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

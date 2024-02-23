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
        HStack{
            CircleProfileImageView(user: UserService.shared.currentUser)
                .frame(width: StandardImage.width, height: StandardImage.height)
            // Nickname and Best Time
            VStack(alignment: .leading, spacing: 4) {
                Text("Session on \(session.startTime, formatter: itemFormatter)")
                    .bold()
                    .font(.system(size: 14))
                HStack{
                    Text("Best lap: ")
                    Text(String(format: "%.2f", bestLapTime ?? 0))
                        .font(.system(size: 14))
                }
            
            }
        }   .padding(8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }
    
    
    private var itemFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}



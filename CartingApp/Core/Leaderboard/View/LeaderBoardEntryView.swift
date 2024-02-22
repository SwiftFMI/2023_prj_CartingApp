//
//  LeaderboardEntryView.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 22.02.24.
//

import Foundation
import SwiftUI

struct LeaderboardEntryView: View {
    let position: Int
    let name: String
    let bestLapTime: Double

    var body: some View {
        HStack {
            Text("\(position)")
                .font(.headline)
                .foregroundColor(.blue)
                .frame(width: 30, alignment: .leading)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)

                HStack{
                    Text("Best lap: ").font(.subheadline)
                    Text(String(format: "%.3f", bestLapTime))
                        .font(.subheadline)
                }
            }

            Spacer()
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

//#Preview(){
//    LeaderboardEntryView()
//}

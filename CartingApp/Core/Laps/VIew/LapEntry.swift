//
//  LapEntry.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 23.02.24.
//

import Foundation
import SwiftUI

struct LapEntry: View {
    
    let lap: Lap
    
    var body: some View {
        HStack{
            CircleProfileImageView(user: UserService.shared.currentUser)
                .frame(width: StandardImage.width, height: StandardImage.height)
            // Nickname and Best Time
            HStack{
                Text("Lap Time: ")
                Text(String(format: "%.2f", lap.lapTime))
                    .font(.system(size: 14))
            }

        }   .padding(8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(5)
    }

}

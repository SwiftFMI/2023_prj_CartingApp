//
//  ProfileHeaderView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct ProfileHeaderView: View {
    var user: User?
    
    init(user: User?){
        self.user = user
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading, spacing: 4){
                    Text(user?.nickname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(user?.fullname ?? "")
                        .font(.subheadline)
                        .font(.caption2)
                }
                if let bestTime = user?.bestTime {
                    HStack{
                        Spacer()
                        Text("Best time: \(bestTime, specifier: "%.2f")")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }
            }
            Spacer()
            if let hasUser = user {
                CircleProfileImageView(user: hasUser)
                    .frame(width: ProfileImage.width, height: ProfileImage.height)
            }
        }.padding()
    }
}

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
                    Text(user?.fullname ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(user?.nickname ?? "")
                        .font(.subheadline)
                        .font(.caption2)
                    
                }
            }
            Spacer()
            CircleProfileImageView()
        }.padding()
    }
}

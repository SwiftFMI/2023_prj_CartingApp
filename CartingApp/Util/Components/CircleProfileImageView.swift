//
//  CircleProfileImageView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct CircleProfileImageView: View {
    var user: User?
    
    init(user: User?){
        self.user = user
    }
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl, let url = URL(string: imageUrl) {
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
//             .frame(width: ProfileImage.width, height: ProfileImage.height)
            .clipShape(Circle())
            .shadow(radius: 5)
        } else {
            Image("BioProfilePicture")
                .resizable()
                .scaledToFill()
//                 .frame(width: ProfileImage.width, height: ProfileImage.height)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
    }
}

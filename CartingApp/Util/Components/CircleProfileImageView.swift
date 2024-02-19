//
//  CircleProfileImageView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct CircleProfileImageView: View {
    var body: some View {
        Image("BioProfilePicture")
            .resizable()
            .scaledToFill()
            .frame(width: ProfileImage.width, height: ProfileImage.height)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CircleProfileImageView()
}

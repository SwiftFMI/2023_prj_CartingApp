//
//  UserCellView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack{
            CircleProfileImageView()
            VStack (alignment:.leading, spacing:4){
                HStack{
                    Text(user.username)
                        .fontWeight(.semibold)
                    
                }
                Text(user.fullname)
                    
            }.font(.footnote)
            Spacer()
            
            Text("AddFriend")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height:32)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
        }.padding(.horizontal)
    }
}

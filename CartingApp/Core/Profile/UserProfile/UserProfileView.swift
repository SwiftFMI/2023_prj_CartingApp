//
//  UserProfileView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        
        ScrollView (showsIndicators: false) {
            VStack (spacing:20){
                ProfileHeaderView(user: user)
                
                Button {
                    
                }label:{
                    Text("Add Firend")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width:352, height: 32)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                UserContentView(user: user)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        
    }
}

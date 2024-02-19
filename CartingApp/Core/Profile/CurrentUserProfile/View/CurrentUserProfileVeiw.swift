//
//  CurrentUserProfileVeiw.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false
    
    @MainActor
    private var currentUser: User? {
        return viewModel.currentUser
    }
    
    var body: some View {
        NavigationStack{
            ScrollView (showsIndicators: false) {
                VStack (spacing:20){
                    ProfileHeaderView(user: currentUser)
                    
                    Button {
                        showEditProfile.toggle()
                    }label:{
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black)
                            .frame(width:176, height: 32)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay{
                                RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    UserContentListView()
                }
                
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = currentUser{
                    EditProfileView(user: user)
                }
                    
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        AuthService.shared.signOut()
                    } label:{
                        Text("Sign Out")
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview("English") {
    CurrentUserProfileView()
}

#Preview("Bulgarian") {
    CurrentUserProfileView()
        .environment(\.locale, Locale(identifier: "bg"))
}



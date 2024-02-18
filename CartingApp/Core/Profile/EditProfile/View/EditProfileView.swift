//
//  EditProfileView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI
import PhotosUI

struct EditProfileView: View {
    let user: User
    @State private var bio = ""
    @State private var link = ""
    @State private var isPrivateProfile = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = EditProfileViewModel()

    var body: some View {
        NavigationStack{
            ZStack{
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name")
                                .fontWeight(.semibold)
                            Text(user.fullname)
                        }
                        
                        Spacer()
                        
                        PhotosPicker(selection: $viewModel.selectedItem){
                            if let image = viewModel.profileImage{
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height:40)
                                    .clipShape(Circle())
                            } else {
                                HStack {
                                    Text("Change photo")
                                    CircleProfileImageView()
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
                
            }
            
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .topBarLeading){
                    Button ("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.black)
                    
                }
                ToolbarItem (placement: .topBarTrailing){
                    Button ("Done") {
                        Task {try await viewModel.updateUerData()}
                        dismiss()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
                    
                }
            }
        }
    }
}

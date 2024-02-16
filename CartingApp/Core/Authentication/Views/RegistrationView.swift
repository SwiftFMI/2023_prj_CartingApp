//
//  RegistrationView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    
    @StateObject var viewModel = RegistrationViewModel()
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                TextField("Email", text: $viewModel.email)
                    .modifier(ThreadsTextViewModifier())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(ThreadsTextViewModifier())
                
                TextField("Full Name", text: $viewModel.fullname)
                    .modifier(ThreadsTextViewModifier())
                
                TextField("Username", text: $viewModel.username)
                    .modifier(ThreadsTextViewModifier())
                
            } .padding()
            Button {
                Task{ try await viewModel.createUser()}
            } label: {
                Text("Sign Up")
                    .modifier(ThreadsButtonViewModifier())
            }
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                    Text("Login").bold()
                }
                .foregroundStyle(Color.black)
                .font(.footnote)
            }
            .padding(.vertical, 14)
        }
    }
}

#Preview("English") {
    RegistrationView()
}

#Preview("Bulgarian") {
    RegistrationView()
        .environment(\.locale, Locale(identifier: "bg"))
}

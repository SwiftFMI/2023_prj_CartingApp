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
    @State private var showAlert =  false;
    @State private var alertMessage = "";
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
                TextField("Email", text: $viewModel.email)
                    .modifier(TextViewModifier())
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(TextViewModifier())
                
                TextField("Full Name", text: $viewModel.fullname)
                    .modifier(TextViewModifier())
                
                TextField("Nickname", text: $viewModel.nickname)
                    .modifier(TextViewModifier())
                
            } .padding()
            Button {
                Task{
                    do{
                        try await viewModel.createUser()
                        showAlert = true
                        alertMessage = "Successful registration"
                    }catch{
                            showAlert = true
                            alertMessage = error.localizedDescription
                        }
                    }
            } label: {
                Text("Sign Up")
                    .modifier(ButtonViewModifier())
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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

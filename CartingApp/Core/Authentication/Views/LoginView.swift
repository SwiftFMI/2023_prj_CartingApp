//
//  LoginView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                VStack{
                    TextField("Email", text: $viewModel.email)
                        .modifier(ThreadsTextViewModifier())

                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(ThreadsTextViewModifier())

                    
                }
                .padding(.horizontal,30)
                NavigationLink {
                    Text("Forgot Password")
                    
                }  label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing)
                        .foregroundColor(.black)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                } .padding(10)
                
                Button {
                    Task {try await viewModel.loginUser()}
                } label: {
                    Text("Login")
                        .modifier(ThreadsButtonViewModifier())
                }
                
                Spacer()
                Divider()
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have and account?")
                        Text("Sign up!")
                    }
                    .foregroundStyle(Color.black)
                    .font(.footnote)
                }
                .padding(.vertical, 14)
            }
        }
    }
}

#Preview("English") {
    LoginView()
}

#Preview("Bulgarian") {
    LoginView()
        .environment(\.locale, Locale(identifier: "bg"))
}

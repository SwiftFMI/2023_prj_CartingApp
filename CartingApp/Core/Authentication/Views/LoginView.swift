//
//  LoginView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var showAlert =  false;
    @State private var alertMessage = "";
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                VStack{
                    TextField("Email", text: $viewModel.email)
                        .modifier(TextViewModifier())

                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(TextViewModifier())

                    
                }
                .padding(.horizontal,30)
                NavigationLink {
                    TextField("Email", text: $viewModel.email)
                        .modifier(TextViewModifier())
                        .padding(.horizontal,30)

                    Button {
                        Task {try await viewModel.sendPasswordResetEmail()}
                    } label: {
                        Text("send password reset email")
                            .modifier(ButtonViewModifier())
                    }
                    .padding(20)
                    
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
                    Task {
                        do{
                            try await viewModel.loginUser()
                        }catch{
                                showAlert = true
                                alertMessage = error.localizedDescription
                            }
                    }
                } label: {
                    Text("Login")
                        .modifier(ButtonViewModifier())
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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

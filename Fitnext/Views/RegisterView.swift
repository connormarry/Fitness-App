//
//  RegisterView.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack{
            HeaderView(title: "Register",
                       subtitle: "free account", rotation: -10, background: .green)
            
            Form{
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                FNButton(
                    title: "Create Account",
                    background: .blue)
                {
                    viewModel.register()
                }
                    .padding()
                
            }
            .padding(.bottom, 50)
            Spacer()
        }
    }
}

#Preview {
    RegisterView()
}

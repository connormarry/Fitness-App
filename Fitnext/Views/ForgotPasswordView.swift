//
//  ForgotPasswordView.swift
//  Fitnext
//
//  Created by Connor Marry on 6/3/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            
            HeaderView(title:"FITNEXT",
                       subtitle: "No more excuses...",
                       rotation: -10,
                       background: .blue)
            
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding()
            
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            FNButton(
                title: "Reset Password",
                background: .blue)
            {
                viewModel.resetPassword()
                
            }
            .frame(width: 350, height: 75)
            .padding()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}

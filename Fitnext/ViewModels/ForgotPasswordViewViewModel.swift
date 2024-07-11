//
//  ForgotPasswordViewViewModel.swift
//  Fitnext
//
//  Created by Connor Marry on 6/3/24.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String = ""
    
    func resetPassword() {
        // Implement logic to send password reset link
        // For example, you can use Firebase Auth
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = "Password reset email sent. Check your inbox."
            }
        }
    }
}

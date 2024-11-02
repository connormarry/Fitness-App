//
//  LogoutViewViewModel.swift
//  Fitnext
//
//  Created by Connor Marry on 6/3/24.
//

import Foundation
import FirebaseAuth

class LogoutViewViewModel : ObservableObject {
    func logout() {
        do {
            try Auth.auth().signOut()
            // Clear any user-related data or perform any other necessary cleanup
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}


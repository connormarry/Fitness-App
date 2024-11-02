//
//  FitnextApp.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import SwiftUI
import FirebaseCore

@main
struct FitnextApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

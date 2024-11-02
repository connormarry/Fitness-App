//
//  ContentView.swift
//  Fitnext
//
//  Created by Connor Marry on 5/30/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserID.isEmpty {
            // signed in
            HomeView()
        } else {
            LoginView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        MainView()
    }
}

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top){
                //Header
                HeaderView(title: "FITNEXT",
                        subtitle: "No more excuses...",
                        rotation: -10,
                        background: .blue)
                .padding(.top, 40) // Space from Dynamic Island
                .frame(maxWidth: .infinity) // Fill the width
                .edgesIgnoringSafeArea(.top)
                
                //Login Form
                ScrollView { 
                    // Wrap your VStack in a ScrollView
                    VStack {
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        TextField("Email Address", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .frame(width: 350)
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .frame(width: 350)
                        
                        FNButton(
                            title: "Log In",
                            background: .blue)
                        {
                            viewModel.login()
                        }
                        .padding()
                        .frame(width: 350, height: 75)
                    }
                    .padding(.top, 400)
                    //Create Account
                    HStack{
                        VStack{
                            Text("New User?")
                            NavigationLink("Create Account",
                                           destination: RegisterView())
                        }
                        
                        VStack{
                            Text("Forgot Password?")
                            NavigationLink("Reset Password",
                                            destination: ForgotPasswordView())
                        }
                    }
                    .padding(.bottom, 50)
                    
                    Spacer()
                }
                .offset(y: -50)
                
              
            }
            .padding(.bottom, keyboardHeight()) // Adjust the bottom padding based on the keyboard height
            .edgesIgnoringSafeArea(.bottom) // Ignore safe area to prevent content from being obscured by the keyboard
        }
    }
    
    // Function to get keyboard height
    private func keyboardHeight() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let mainWindow = windowScene.windows.first else {
            return 0
        }
        let keyboardFrame = mainWindow.safeAreaInsets.bottom
        return keyboardFrame
    }
}

#Preview {
    LoginView()
}

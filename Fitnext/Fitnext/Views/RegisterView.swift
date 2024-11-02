import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                // Header
                HeaderView(title: "Register",
                           subtitle: "Free Account",
                           rotation: -10,
                           background: .green)
                    .padding(.top, 40) // Space from Dynamic Island
                    .frame(maxWidth: .infinity) // Fill the width
                    .edgesIgnoringSafeArea(.top)
                
                // Scrollable Content
                ScrollView {
                    VStack {
                        VStack() {
                            TextField("Full Name", text: $viewModel.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                                .frame(width: 350)
                            
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
                                title: "Create Account",
                                background: .blue) {
                                viewModel.register()
                            }
                            .padding()
                            .frame(width: 350, height: 75) // Set button size
                        }
                        .padding(.top, 300) // Top padding for form
                        .padding(.bottom, keyboardHeight) // Adjust for keyboard
                        
                        Spacer()
                    }
                }
                .onAppear {
                    // Keyboard observers
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                        withAnimation {
                            keyboardHeight = 300 // Adjust this height as needed
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                        withAnimation {
                            keyboardHeight = 0
                        }
                    }
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self)
                }
            }
            .padding(.bottom, keyboardHeight) // Ensure space for the keyboard
        }
    }
}

#Preview {
    RegisterView()
}

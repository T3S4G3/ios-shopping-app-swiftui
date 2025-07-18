import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginError: String?
    @State private var isLoggedIn: Bool = false
    @State private var showPassword: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // App logo/title section
            VStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Text("🛍️")
                            .font(.system(size: 40))
                    )
                
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Sign in to continue shopping")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            // Login form
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Username")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    TextField("Enter your username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.body)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    HStack {
                        if showPassword {
                            TextField("Enter your password", text: $password)
                                .font(.body)
                        } else {
                            SecureField("Enter your password", text: $password)
                                .font(.body)
                        }
                        
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Text(showPassword ? "Hide" : "Show")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .padding(.horizontal)
            
            // Error message
            if let error = loginError {
                Text(error)
                    .font(.body)
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            
            // Login button
            Button(action: {
                performLogin()
            }) {
                Text("Login")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .disabled(username.isEmpty || password.isEmpty)
            .opacity(username.isEmpty || password.isEmpty ? 0.6 : 1.0)
            
            // Additional options
            VStack(spacing: 12) {
                Button(action: {
                    // Implement forgot password logic
                    print("Forgot password tapped")
                }) {
                    Text("Forgot Password?")
                        .font(.body)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Text("Don't have an account?")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Button(action: {
                        // Implement sign up logic
                        print("Sign up tapped")
                    }) {
                        Text("Sign Up")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Login Successful", isPresented: $isLoggedIn) {
            Button("Continue") {
                // Navigate to main app or dismiss login
                print("Login successful for user: \(username)")
            }
        } message: {
            Text("Welcome back, \(username)!")
        }
    }
    
    private func performLogin() {
        // Reset previous error
        loginError = nil
        
        // Basic validation
        guard !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            loginError = "Please enter your username."
            return
        }
        
        guard !password.isEmpty else {
            loginError = "Please enter your password."
            return
        }
        
        guard password.count >= 6 else {
            loginError = "Password must be at least 6 characters long."
            return
        }
        
        // Simulate login process
        // In a real app, you would make an API call here
        if username.lowercased() == "demo" && password == "password123" {
            isLoggedIn = true
        } else {
            loginError = "Invalid username or password. Try 'demo' and 'password123'."
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}

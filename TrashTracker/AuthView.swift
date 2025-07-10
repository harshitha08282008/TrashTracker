import SwiftUI
struct AuthView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("userPassword") private var userPassword = ""
    @AppStorage("username") private var username = ""
    @AppStorage("userType") private var userType = ""
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var newUsername = ""
    @State private var errorMessage = ""
    var body: some View {
        ZStack {
            Color.softSage.ignoresSafeArea()
            VStack(spacing: 20) {
                Text(isSignUp ? "Create Account" : "Sign In")
                    .font(.largeTitle.bold())
                    .foregroundColor(.accentOlive)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if isSignUp {
                    TextField("Username", text: $newUsername)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                Button(isSignUp ? "Create Account" : "Sign In") {
                    if isSignUp {
                        if !email.isEmpty && !password.isEmpty && !newUsername.isEmpty {
                            userEmail = email
                            userPassword = password
                            username = newUsername
                            userType = "reporter"
                            isLoggedIn = true
                        } else {
                            errorMessage = "Please fill in all fields."
                        }
                    } else {
                        if email == userEmail && password == userPassword {
                            isLoggedIn = true
                        } else {
                            errorMessage = "Invalid email or password."
                        }
                    }
                }
                .buttonStyle(GreenButtonStyle())
                Button(isSignUp ? "Already have an account? Sign In" : "No account? Create one") {
                    isSignUp.toggle()
                    errorMessage = ""
                }
                .foregroundColor(.accentOlive)
            }
            .padding()
        }
    }
}


import SwiftUI
import SwiftData
struct CreateAccountView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("username") private var username = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var enteredEmail = ""
    @State private var enteredUsername = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Query private var existingUsers: [AppUser]
    var body: some View {
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle.bold())
                .foregroundColor(.accentOlive)
            TextField("Email", text: $enteredEmail)
                .textFieldStyle(.roundedBorder)
            TextField("Username", text: $enteredUsername)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Create Account") {
                if existingUsers.contains(where: { $0.email == enteredEmail }) {
                    alertMessage = "There’s already an account with this email!"
                    showAlert = true
                } else {
                    let newUser = AppUser(email: enteredEmail, username: enteredUsername, password: password)
                    modelContext.insert(newUser)
                    try? modelContext.save()
                    userEmail = enteredEmail
                    username = enteredUsername
                    isLoggedIn = true
                }
            }
            .buttonStyle(GreenButtonStyle())
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        }
        .padding()
        .background(Color.softSage.ignoresSafeArea())
    }
}

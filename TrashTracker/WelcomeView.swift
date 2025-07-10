import SwiftUI
struct WelcomeView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userType") private var userType = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome! Choose user type to login:")
            Button("Login as Reporter") {
                userType = "reporter"
                isLoggedIn = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            Button("Login as Volunteer") {
                userType = "volunteer"
                isLoggedIn = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}


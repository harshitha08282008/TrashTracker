import SwiftUI
struct AccountView: View {
    @AppStorage("username") private var username = ""
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("userType") private var userType = ""
    @AppStorage("cleanupsSignedUp") private var cleanupsSignedUp = 0
    @AppStorage("tasksResolved") private var tasksResolved = 0
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("My Account")
                    .font(.largeTitle.bold())
                    .foregroundColor(.accentOlive)
                Text("👤 Username: \(username)")
                Text("📧 Email: \(userEmail)")
                Text("🎭 Role: \(userType.capitalized)")
                Text("📅 Cleanups Signed Up: \(cleanupsSignedUp)")
                Text("✅ Tasks Resolved: \(tasksResolved)")
                Button("Switch to Reporter") { userType = "reporter" }
                    .buttonStyle(GreenButtonStyle())
                Button("Switch to Volunteer") { userType = "volunteer" }
                    .buttonStyle(GreenButtonStyle())
                Button("Log Out") {
                    isLoggedIn = false
                    userType = ""
                    userEmail = ""
                    username = ""
                    cleanupsSignedUp = 0
                    tasksResolved = 0
                }
                .buttonStyle(GreenButtonStyle())
            }
            .padding()
            .background(Color.softSage.ignoresSafeArea())
        }
    }
}


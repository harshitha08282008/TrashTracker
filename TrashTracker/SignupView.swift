import SwiftUI
import SwiftData
struct SignupView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("userType") private var userTypeRaw = ""
    var userType: UserType
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        Form {
            Section(header: Text("Sign Up")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign Up") {
                    let newUser = User(name: name, email: email, password: password, userType: userType)
                    modelContext.insert(newUser)
                    do {
                        try modelContext.save()
                        userEmail = email
                        userTypeRaw = userType.rawValue
                        isLoggedIn = true
                    } catch {
                        print("Error saving user: \(error.localizedDescription)")
                    }
                }
            }
        }
        .navigationTitle("Sign Up")
    }
}


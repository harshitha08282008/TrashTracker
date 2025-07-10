import SwiftUI
struct ContentView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userType") private var userType = ""
    @AppStorage("userEmail") private var userEmail = ""
    var body: some View {
        if isLoggedIn {
            TabView {
                if userType == "reporter" {
                    ReporterHomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                } else {
                    VolunteerTasksView()
                        .tabItem {
                            Label("Tasks", systemImage: "list.bullet")
                        }
                }
                AccountView()
                    .tabItem {
                        Label("My Account", systemImage: "person.circle")
                    }
            }
        } else {
            AuthView()
        }
    }
}


import Foundation
import SwiftData
@Model
class AppUser {
    var email: String
    var username: String
    var password: String
    init(email: String, username: String, password: String) {
        self.email = email
        self.username = username
        self.password = password
    }
}

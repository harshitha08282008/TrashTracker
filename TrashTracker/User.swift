import Foundation
import SwiftData
enum UserType: String, Codable {
    case reporter
    case volunteer
}
@Model
class User {
    var id: UUID = UUID()
    var name: String
    var email: String
    var password: String
    var userType: UserType
    init(name: String, email: String, password: String, userType: UserType) {
        self.name = name
        self.email = email
        self.password = password
        self.userType = userType
    }
}

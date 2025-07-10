import Foundation
import SwiftData
@Model
class CommunityEvent: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var location: String
    var time: String
    var eventDescription: String
    var signedUpUsers: [String]
    init(title: String, location: String, time: String, eventDescription: String, signedUpUsers: [String]) {
        self.id = UUID()
        self.title = title
        self.location = location
        self.time = time
        self.eventDescription = eventDescription
        self.signedUpUsers = signedUpUsers
    }
}


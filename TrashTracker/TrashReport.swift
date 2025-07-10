import Foundation
import SwiftData
@Model
class TrashReport {
    @Attribute(.unique) var id: UUID
    var location: String
    var trashType: String
    var reportDescription: String
    var imageData: Data?
    var reporterEmail: String
    var volunteerUsername: String?
    var isResolved: Bool
    init(location: String, trashType: String, reportDescription: String, imageData: Data? = nil, reporterEmail: String, volunteerUsername: String? = nil, isResolved: Bool = false) {
        self.id = UUID()
        self.location = location
        self.trashType = trashType
        self.reportDescription = reportDescription
        self.imageData = imageData
        self.reporterEmail = reporterEmail
        self.volunteerUsername = volunteerUsername
        self.isResolved = isResolved
    }
}


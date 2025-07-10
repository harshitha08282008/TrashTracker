import SwiftUI
import SwiftData
struct CommunityCleanupView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("userEmail") private var userEmail = ""
    @Query private var allEvents: [CommunityEvent]
    @State private var title = ""
    @State private var location = ""
    @State private var eventDescription = ""
    @State private var date = Date()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Plan a Cleanup Event")
                        .font(.headline)
                    TextField("Event Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                    TextField("Location", text: $location)
                        .textFieldStyle(.roundedBorder)
                    TextEditor(text: $eventDescription)
                        .frame(height: 80)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                    DatePicker("Select Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.graphical)
                    Button("Create Event") {
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        formatter.timeStyle = .short
                        let formattedTime = formatter.string(from: date)
                        let newEvent = CommunityEvent(
                            title: title,
                            location: location,
                            time: formattedTime,
                            eventDescription: eventDescription,
                            signedUpUsers: []
                        )
                        modelContext.insert(newEvent)
                        try? modelContext.save()
                        // Reset fields
                        title = ""
                        location = ""
                        eventDescription = ""
                        date = Date()
                    }
                    .disabled(title.isEmpty || location.isEmpty || eventDescription.isEmpty)
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom, 30)
                    Divider()
                    Text("Community Events")
                        .font(.title2)
                        .bold()
                    ForEach(allEvents) { event in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(event.title).font(.headline)
                            Text("📍 \(event.location)")
                            Text("🕒 \(event.time)")
                            Text("📝 \(event.eventDescription)")
                            Text("👥 Signed Up: \(event.signedUpUsers.count)")
                            if event.signedUpUsers.contains(userEmail) {
                                Text("✅ Signed Up")
                                    .foregroundColor(.green)
                            } else {
                                Button("Sign Up") {
                                    if !event.signedUpUsers.contains(userEmail) {
                                        event.signedUpUsers.append(userEmail)
                                        try? modelContext.save()
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                            Divider()
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding()
            }
            .navigationTitle("Community Cleanup")
        }
    }
}

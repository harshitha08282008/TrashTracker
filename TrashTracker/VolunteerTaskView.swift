import SwiftUI
import SwiftData
struct VolunteerTasksView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("userEmail") private var userEmail = ""
    @AppStorage("username") private var username = "" // ✅ Store the volunteer username
    @AppStorage("tasksResolved") private var tasksResolved = 0
    @Query private var allReports: [TrashReport]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Available Tasks")
                        .font(.title2.bold())
                        .foregroundColor(.accentOlive)
                    ForEach(allReports.filter { !$0.isResolved && $0.volunteerUsername == nil }) { report in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📍 Location: \(report.location)")
                            Text("🗑 Trash Type: \(report.trashType)")
                            Text("📝 Description: \(report.reportDescription)")
                            if let imageData = report.imageData,
                               let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Button("Take On Task") {
                                report.volunteerUsername = username
                                try? modelContext.save()
                            }
                            .buttonStyle(GreenButtonStyle())
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    Text("My Cleanup Tasks")
                        .font(.title2.bold())
                        .foregroundColor(.accentOlive)
                        .padding(.top, 20)
                    ForEach(allReports.filter { $0.volunteerUsername == username }) { report in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("📍 Location: \(report.location)")
                            Text("🗑 Trash Type: \(report.trashType)")
                            Text("📝 Description: \(report.reportDescription)")
                            Text("✅ Status: \(report.isResolved ? "Resolved" : "Unresolved")")
                                .foregroundColor(report.isResolved ? .green : .red)
                            if let imageData = report.imageData,
                               let image = UIImage(data: imageData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            if !report.isResolved {
                                Button("Mark as Resolved") {
                                    report.isResolved = true
                                    tasksResolved += 1
                                    try? modelContext.save()
                                }
                                .buttonStyle(GreenButtonStyle())
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    VStack(spacing: 12) {
                        NavigationLink("Trash Disposal Tips") {
                            DisposalTipsView()
                        }
                        .buttonStyle(GreenButtonStyle())
                        NavigationLink("Community Cleanup Events") {
                            CommunityCleanupView()
                        }
                        .buttonStyle(GreenButtonStyle())
                    }
                    .padding(.top, 30)
                }
                .padding()
            }
            .background(Color.softSage.ignoresSafeArea())
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Volunteer Tasks")
                        .font(.largeTitle.bold())
                        .foregroundColor(.accentOlive)
                }
            }
        }
    }
}


import SwiftUI
import SwiftData
struct ReporterHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("userEmail") private var userEmail = ""
    @Query private var allReports: [TrashReport]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    NewReportForm()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Past Reports")
                            .font(.headline)
                            .foregroundColor(.accentOlive)
                        ForEach(allReports.filter { $0.reporterEmail == userEmail }) { report in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("📍 Location: \(report.location)")
                                Text("🗑 Type: \(report.trashType)")
                                Text("📝 Description: \(report.reportDescription)")
                                Text("✅ Status: \(report.isResolved ? "Resolved" : "Unresolved")")
                                    .foregroundColor(report.isResolved ? .green : .red)
                                if let volunteer = report.volunteerUsername {
                                    Text("🧑‍🤝‍🧑 Taken by: \(volunteer)")
                                }
                                if let imageData = report.imageData,
                                   let image = UIImage(data: imageData) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    VStack(spacing: 10) {
                        NavigationLink("Trash Disposal Tips") {
                            DisposalTipsView()
                        }
                        .buttonStyle(GreenButtonStyle())
                        NavigationLink("Community Cleanup Events") {
                            CommunityCleanupView()
                        }
                        .buttonStyle(GreenButtonStyle())
                    }
                    .padding(.top, 20)
                }
                .padding()
            }
            .background(Color.softSage.ignoresSafeArea())
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Reporter Home")
                        .font(.largeTitle.bold())
                        .foregroundColor(.accentOlive)
                }
            }
        }
    }
}
struct NewReportForm: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("userEmail") private var userEmail = ""
    @State private var location = ""
    @State private var trashType = ""
    @State private var reportDescription = ""
    @State private var selectedImage: UIImage?
    @State private var imageData: Data?
    @State private var showImagePicker = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New Trash Report")
                .font(.headline)
                .foregroundColor(.accentOlive)
            TextField("Location", text: $location)
                .textFieldStyle(.roundedBorder)
            TextField("Trash Type", text: $trashType)
                .textFieldStyle(.roundedBorder)
            TextField("Description", text: $reportDescription)
                .textFieldStyle(.roundedBorder)
            Button("Select Image") {
                showImagePicker = true
            }
            .buttonStyle(GreenButtonStyle())
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $selectedImage, imageData: $imageData)
            }
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
            }
            Button("Submit Report") {
                let newReport = TrashReport(
                    location: location,
                    trashType: trashType,
                    reportDescription: reportDescription,
                    imageData: imageData,
                    reporterEmail: userEmail
                )
                modelContext.insert(newReport)
                try? modelContext.save()
                location = ""
                trashType = ""
                reportDescription = ""
                selectedImage = nil
                imageData = nil
            }
            .buttonStyle(GreenButtonStyle())
            .padding(.top, 6)
        }
    }
}


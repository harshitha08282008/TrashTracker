import SwiftUI
struct DisposalTipsView: View {
    let tips = [
        ("Plastic Bottles", "Recycle plastic bottles in the blue bin. Rinse before recycling."),
        ("Glass", "Recycle glass jars and bottles. Do not recycle broken glass."),
        ("Food Waste", "Compost food waste if possible. Avoid putting it in trash bins."),
        ("Electronics", "Take electronics to designated e-waste centers."),
        ("Batteries", "Dispose of batteries at special collection points.")
    ]
    var body: some View {
        List {
            ForEach(tips, id: \.0) { tip in
                VStack(alignment: .leading, spacing: 6) {
                    Text(tip.0)
                        .font(.headline)
                    Text(tip.1)
                        .font(.subheadline)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Trash Disposal Tips")
    }
}

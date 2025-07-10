import SwiftUI
// MARK: - Elegant Green Theme Colors
extension Color {
    static let softSage = Color(red: 230 / 255, green: 240 / 255, blue: 230 / 255)     // pastel green background
    static let accentOlive = Color(red: 60 / 255, green: 80 / 255, blue: 60 / 255)      // forest green for buttons/text
}
// MARK: - Global Button Style
struct GreenButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentOlive)
            .foregroundColor(.white)
            .font(.headline)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}



import SwiftUI


struct CircleButton: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
            )
            .overlay {
                Circle()
                    .stroke(.accent, lineWidth: 0.2)
            }
    }
}


#Preview {
    CircleButton(imageName: "info")
}

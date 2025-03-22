
import SwiftUI


struct PrimaryButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(color.opacity(0.8))
                )
                .padding()
        }
        .padding(.bottom, 32)
    }
}


#Preview {
    ZStack {
        GeometryReader { geo in
            Image("WeatherBackground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width)
                .ignoresSafeArea()
        }
        
        VStack {
            PrimaryButton(title: "Allow!", color: .green) {}
            
            PrimaryButton(title: "Go to settings", color: .yellow) {}
            
            PrimaryButton(title: "Try again", color: .blue) {}
        }
    }
    
}

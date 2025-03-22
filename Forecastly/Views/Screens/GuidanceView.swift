
import SwiftUI


struct GuidanceView: View {
    var body: some View {
        
        ZStack {
            
            backgroundImage
            
            VStack(spacing: 0) {

                guidanceView
                
                PrimaryButton(title: "Open Settings", color: .green) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                .padding(.horizontal, 32)
            }
        }

    }
}

#Preview {
    GuidanceView()
}


// MARK: - Views

extension GuidanceView {
    private var backgroundImage: some View {
        GeometryReader { geo in
            Image("WeatherBackground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width)
                .ignoresSafeArea()
        }
    }
    
    private var guidanceView: some View {
        Group {
            Image(systemName: "location.slash.fill")
                .font(.system(size: 72))
                .opacity(0.6)
            
            Text("Location use is Denied! 😢")
                .font(.title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .bold()
                .padding(.top, 12)
                .padding(.horizontal, 48)
            
            Text("""
                    1. Tap the button below and go to "Privacy and Security"
                    2. Tap on "Location Services"
                    3. Locate the "Forecastly" App and tap on it
                    4. Change the setting to "While Using the App
                    """)
            .opacity(0.8)
            .bold()
            .multilineTextAlignment(.leading)
            .padding(.top, 12)
            .padding(.horizontal, 48)
        }
    }
}

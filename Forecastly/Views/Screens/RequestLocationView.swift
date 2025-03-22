
import SwiftUI


struct RequestLocationView: View {
    
    @Environment(LocationManager.self) var locationManager
    
    var body: some View {
        ZStack {
            
            backgroundImage
            
            VStack {
                
                requestLocationMessageView
                
                PrimaryButton(title: "Allow", color: .green) {
                    locationManager.requestAuthorization()
                }
            }
        }

    }
}

#Preview {
    RequestLocationView()
        .environment(LocationManager.shared)
}


// MARK: - Views

extension RequestLocationView {
    
    private var backgroundImage: some View {
        GeometryReader { geo in
            Image("WeatherBackground")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width)
                .ignoresSafeArea()
        }
    }
    
    private var requestLocationMessageView: some View {
        Group {
            Text("Please, allow the App to access your current location, so you can see the forecast! 🧐")
                .font(.title2)
                .bold()
                .padding(.horizontal, 32)
                .padding(.top, 62)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Image(systemName: "location")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 150, height: 150)
                .padding(.top, 72)
            
            Text("To start using Forecastly you need to allow for location access ")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 48)
                .padding(.top, 16)
            
            Spacer()
            
        }
    }
    
}



import SwiftUI

@main
struct ForecastlyApp: App {
    
    @State private var locationManager: LocationManager = LocationManager.shared
    
    var body: some Scene {
        WindowGroup {
           
            if locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse
            {
                // User allowed to use their location
                HomeView(forecastDataManager: ProductionForecastDataManager())
                    .preferredColorScheme(.dark)

            } else if locationManager.authorizationStatus == .notDetermined {
                
                // User has not yet allowed to use their location
                RequestLocationView()
                    .preferredColorScheme(.dark)
                
            } else if locationManager.authorizationStatus == .denied {
                
                // The user has denied access to their location
                GuidanceView()
                    .preferredColorScheme(.dark)
                
            } else if locationManager.authorizationStatus == .restricted {
                
                // Not handled
            }
        }
        .environment(locationManager)
    }
}

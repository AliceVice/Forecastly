
import Foundation
import CoreLocation


@Observable
final class LocationManager: NSObject {
    
    @ObservationIgnored private let manager = CLLocationManager()
    @ObservationIgnored static let shared = LocationManager()
    
    public var userLocation: CLLocation?
    public var authorizationStatus: CLAuthorizationStatus = .notDetermined
    public var cityName: String = "Unknown"
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 500  // update only when moved 500m
        manager.startUpdatingLocation()
    }
    
    public func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func fetchCityName(for location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    self.cityName = placemark.locality ?? "Unknown"
                }
            } else if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
            
        case .notDetermined:
            authorizationStatus = .notDetermined
            
        case .restricted:
            authorizationStatus = .restricted
            
        case .denied:
            authorizationStatus = .denied
            
        case .authorizedWhenInUse:
            authorizationStatus = .authorizedWhenInUse
            manager.requestLocation()
            
        case .authorizedAlways:
            authorizationStatus = .authorizedAlways
            manager.requestLocation()
            
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = locations.last
            self.fetchCityName(for: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error location: \(error.localizedDescription)")
    }
}



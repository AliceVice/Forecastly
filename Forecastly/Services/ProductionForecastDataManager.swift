
import Foundation
import Combine
import CoreLocation


protocol ForecastDataManager {
    func getForecast(for location: CLLocation) async throws -> Forecast
}


final class ProductionForecastDataManager: ForecastDataManager {
    
    public func getForecast(for location: CLLocation) async throws -> Forecast {
        
        // Create url
        guard let url = makeForecastURL(for: location) else { throw URLError(.badURL) }
        
        // Send the request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Handle response
        guard let response = response as? HTTPURLResponse,
              200..<300 ~= response.statusCode else { throw URLError(.badServerResponse) }

        // Decode forecast and return it
        let forecast = try JSONDecoder().decode(Forecast.self, from: data)
        return forecast
    }
    
    
    private func makeForecastURL(for location: CLLocation) -> URL? {
        
        // main url
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")
        
        // queries
        components?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(location.coordinate.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.coordinate.longitude)"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min,uv_index_max"),
            URLQueryItem(name: "hourly", value: "temperature_2m,weather_code"),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code,precipitation,apparent_temperature,wind_speed_10m,wind_gusts_10m,relative_humidity_2m,wind_direction_10m"),
            URLQueryItem(name: "timezone", value: TimeZone.current.identifier),
            URLQueryItem(name: "wind_speed_unit", value: "ms")
        ]
        
        // final url
        return components?.url
    }

}


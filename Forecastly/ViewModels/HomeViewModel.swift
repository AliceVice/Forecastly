
import Foundation
import CoreLocation


enum ForecastLoadingState {
    case loading
    case loaded
    case error(description: String)
}


@Observable
final class HomeViewModel {

    private(set) var forecast: Forecast = .empty
    public var loadingState: ForecastLoadingState = .loading
    
    @ObservationIgnored private let forecastDataManager: ForecastDataManager
    
    public init(forecastDataManager: ForecastDataManager) {
        self.forecastDataManager = forecastDataManager
    }
    
    public func getForecast(for location: CLLocation) async throws {
        let forecast = try await forecastDataManager.getForecast(for: location)
        self.forecast = forecast
        self.loadingState = .loaded
    }

}



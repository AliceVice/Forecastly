
import Foundation


// Json Data:
/*
 
 URL:
 https://api.open-meteo.com/v1/forecast?latitude=37.785834&longitude=-122.406417&daily=weather_code,temperature_2m_max,temperature_2m_min,uv_index_max&hourly=temperature_2m,weather_code&current=temperature_2m,weather_code,precipitation,apparent_temperature,wind_speed_10m,wind_gusts_10m,relative_humidity_2m,wind_direction_10m&timezone=Europe/Warsaw&wind_speed_unit=ms
 
 */


// MARK: - Forecast models

struct Forecast: Decodable {
    let latitude, longitude: Double
    let timezone, timezoneAbbreviation: String
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case current
        case hourly
        case daily
    }
}

struct Current: Decodable {
    let time: String
    let temperature2M: Double
    let weatherCode: Int
    let precipitation: Double
    let apparentTemperature, windSpeed10M, windGusts10M: Double
    let relativeHumidity2M, windDirection10M: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
        case precipitation
        case apparentTemperature = "apparent_temperature"
        case windSpeed10M = "wind_speed_10m"
        case windGusts10M = "wind_gusts_10m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windDirection10M = "wind_direction_10m"
    }
}

struct Daily: Decodable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2MMax, temperature2MMin, uvIndexMax: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case uvIndexMax = "uv_index_max"
    }
}

struct Hourly: Decodable {
    let time: [String]
    let temperature2M: [Double]
    let weatherCode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case weatherCode = "weather_code"
    }
}



// MARK: - Computing forecast variables that we want

extension Forecast {
    
    /// A tuple array that contains the `hour` as "5 AM" format, the `temp`, and the SF Symbol`imageName` for the weather code for the next 24 hours.
    public var next24Hours: [(hour: String, temp: Double, imageName: String)] {
        
        // 1. Get the index of the first time element
        guard let todaysHourIndex = hourly.time.firstIndex(where: { $0.hourIfDateString() == current.time.hourIfDateString() }) else {
            return [("", 0, "")]
        }
        
        // 2. Merge the arrays into a single tuple array
        let sevenDayHours = hourly.time
        let sevenDaysTemperatures = hourly.temperature2M
        let sevenDaysWeatherCodes = hourly.weatherCode
        
        var merged: [(hour: String, temp: Double, imageName: String)] = []
        
        // Loop from current hour and get the data for the next 24 hours
        for index in stride(from: todaysHourIndex, to: todaysHourIndex + 24, by: 1) {
            
            // Get the image for the weather code
            let imageName = symbolName(for: sevenDaysWeatherCodes[index])
            
            merged.append((hour: sevenDayHours[index].hourIfDateString(),
                           temp: sevenDaysTemperatures[index],
                           imageName: imageName))
        }
        
        // 3 Set the first hour to the "Now" string instead
        merged[0].hour = "Now"
        
        // 4. Return the array
        return merged
    }
    
    /// A tuple array that contains the `day` (as a weekday abbreviation - "Thu", "Wed"), the `minTemp`, the `maxTemp`, and the SF Symbol `imageName` for the weather code for the next 7 days.
    public var next7Days: [(day: String, minTemp: Double, maxTemp: Double, imageName: String, temperatures: [Double])] {
        
        // 1. Merge the arrays into a single tuple array
        var merged: [(day: String, minTemp: Double, maxTemp: Double, imageName: String, temperatures: [Double])] = []
        
        // Use the count from daily.time – assuming all daily arrays have the same count.
        for index in 0..<daily.time.count {
            
            // Extract temperatures for each day
            let sevenDaysTemperatures = hourly.temperature2M
            var dayTemperatures: [Double] = []
            
            let hours = 24 * index // hours too loop on, 0..<24, 24..<48, ... , 144..<168
            
            for i in hours..<(hours + 24) {
                dayTemperatures.append(sevenDaysTemperatures[i])
            }
            
            // Get the day of the Week
            let dayString = daily.time[index]
            let weekday = dayString.weekdayAbbreviation()
            
            // Get the temps and an image
            let minTemp = daily.temperature2MMin[index]
            let maxTemp = daily.temperature2MMax[index]
            let imageName = symbolName(for: daily.weatherCode[index])
            
            merged.append((day: weekday, minTemp: minTemp, maxTemp: maxTemp, imageName: imageName, temperatures: dayTemperatures))
        }
        
        // 3 Set the first day to the "Today" string instead
        merged[0].day = "Today"
        
        // 2. Return merged
        return merged
    }
    
    /// Returns the numeric UV index for today (the first day in `daily.uvIndexMax`)
    /// and a descriptive category (e.g. "Low", "Moderate").
    public var todaysUVIndex: (value: Double, category: String) {
        
        // 1. Get today's UV value (or 0 if missing)
        let uvValue = daily.uvIndexMax.first ?? 0.0
        
        // 2. Compute a category using the standard WHO scale
        let category: String
        switch uvValue {
        case 0..<3:
            category = "Low"
        case 3..<6:
            category = "Moderate"
        case 6..<8:
            category = "High"
        case 8..<11:
            category = "Very High"
        default:
            category = "Extreme"
        }
        
        // Return UV index and its category
        return (uvValue, category)
    }
    
    
    /// Returns the numeric humidity for the current day (relative_humidity_2m)
    /// and a descriptive category (e.g. "Low", "Comfortable", "High").
    public var currentHumidity: (value: Double, category: String) {
        // 1. Get the current humidity or 0 if missing
        let humidity = current.relativeHumidity2M
        
        // 2. Compute a category. (These ranges are just an example.)
        let category: String
        switch humidity {
        case 0..<30:
            category = "Low"
        case 30..<60:
            category = "Comfortable"
        case 60..<80:
            category = "High"
        default:
            category = "Very High"
        }
        
        return (humidity, category)
    }
    
    /// Returns the current temperature (temperature_2m) and the SF Symbol name corresponding to the current weather code.
    public var currentTemp: (temp: Double, imageName: String) {
        let temp = current.temperature2M
        let image = symbolName(for: current.weatherCode)
        return (temp, image)
    }
    
    
    // MARK: Helper functions
    
    /// A helper to map the numeric weather code to an SF Symbol name.
    private func symbolName(for weatherCode: Int) -> String {
        switch weatherCode {
        case 0:
            // Clear sky
            return "sun.max.fill"
        case 1, 2, 3:
            // Mainly clear, partly cloudy, overcast
            return "cloud.sun.fill"
        case 45, 48:
            // Fog, depositing rime fog
            return "cloud.fog.fill"
        case 51, 53, 55:
            // Drizzle
            return "cloud.drizzle.fill"
        case 56, 57:
            // Freezing drizzle
            return "cloud.sleet.fill"
        case 61, 63, 65:
            // Rain
            return "cloud.rain.fill"
        case 66, 67:
            // Freezing rain
            return "cloud.hail.fill"
        case 71, 73, 75:
            // Snow fall
            return "cloud.snow.fill"
        case 77:
            // Snow grains
            return "snowflake"
        case 80, 81, 82:
            // Rain showers
            return "cloud.heavyrain.fill"
        case 85, 86:
            // Snow showers
            return "cloud.snow.fill"
        case 95:
            // Thunderstorm
            return "cloud.bolt.fill"
        case 96, 99:
            // Thunderstorm with slight/heavy hail
            return "cloud.bolt.rain.fill"
        default:
            return "cloud"
        }
    }
}




// MARK: - Empty models

/*
    The empty models were added to decide the problem with optional values.
    If the forecast data was not extracted for some reason, we would have a default empty models.
    But it should not happen
*/

extension Forecast {
    static var empty: Forecast {
        Forecast(
            latitude: 0.0,
            longitude: 0.0,
            timezone: "",
            timezoneAbbreviation: "",
            current: .empty,
            hourly: .empty,
            daily: .empty
        )
    }
}

extension Current {
    static var empty: Current {
        Current(
            time: "",
            temperature2M: 0.0,
            weatherCode: 0,
            precipitation: 0,
            apparentTemperature: 0.0,
            windSpeed10M: 0,
            windGusts10M: 0,
            relativeHumidity2M: 0.0,
            windDirection10M: 0
        )
    }
}

extension Hourly {
    static var empty: Hourly {
        Hourly(
            time: [],
            temperature2M: [],
            weatherCode: []
        )
    }
}

extension Daily {
    static var empty: Daily {
        Daily(
            time: [],
            weatherCode: [],
            temperature2MMax: [],
            temperature2MMin: [],
            uvIndexMax: []
        )
    }
}


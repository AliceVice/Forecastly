
import Foundation


extension String {
    
    /// Returns the hour (e.g. "5 PM") from a date string of the form "2025-03-23T05:00".
    /// If the string doesn't match the format, returns the original string.
    func hourIfDateString() -> String {
        // 1. Create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        // 2. Attempt to parse self into a Date
        guard let date = dateFormatter.date(from: self) else {
            return self
        }

        // 3. Create another formatter for just the hour
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "h a"

        // 4. Return the hour as a string (e.g., "5 PM")
        return hourFormatter.string(from: date)
    }
    
    
    
    /// Converts a date string in the "yyyy-MM-dd" format into a weekday abbreviation (e.g. "Thu", "Fri").
    /// If the string doesn't match, returns the original string.
    func weekdayAbbreviation() -> String {
        
        // 1. Create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        // 2. Attempt to parse self into a Date
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        
        // 3.
        let weekDayFormatter = DateFormatter()
        weekDayFormatter.dateFormat = "EEE"   // e.g., "Thu"
        
        // 4. Return the day of the week in a format "Thu"
        return weekDayFormatter.string(from: date)
    }
    
}



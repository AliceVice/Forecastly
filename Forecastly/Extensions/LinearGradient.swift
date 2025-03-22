
import SwiftUI


extension LinearGradient {

    // This is used to create a custom temperature graph displayed in a daily row
    // An array of tepmeratures for current day is passed (24 hours) and a gradient for them is created
    
    /// Returns temperature gradient for passed array of temperatures.
    static func temperatureGradient(for temperatures: [Double]) -> LinearGradient {
        // Get the colors for temperatures
        let gradientColors = temperatures.map { temp -> Color in
            switch temp {
            case ..<(-24):
                return Color(red: 0.0, green: 0.0, blue: 1.0)    // < -24
            case -24..<(-21):
                return Color(red: 0.15, green: 0.2, blue: 1.0)   // -24..-21
            case -21..<(-18):
                return Color(red: 0.2, green: 0.4, blue: 1.0)    // -21..-18
            case -18..<(-15):
                return Color(red: 0.0, green: 0.6, blue: 1.0)    // -18..-15
            case -15..<(-12):
                return Color(red: 0.0, green: 0.8, blue: 1.0)    // -15..-12
            case -12..<(-9):
                return Color(red: 0.0, green: 1.0, blue: 1.0)    // -12..-9
            case -9..<(-6):
                return Color(red: 0.3, green: 1.0, blue: 1.0)    // -9..-6
            case -6..<(-3):
                return Color(red: 0.7, green: 1.0, blue: 1.0)    // -6..-3
            case -3..<0:
                return Color(red: 1.0, green: 1.0, blue: 1.0)    // -3..0
            case 0..<3:
                return Color(red: 1.0, green: 1.0, blue: 0.8)    // 0..3
            case 3..<6:
                return Color(red: 1.0, green: 1.0, blue: 0.6)    // 3..6
            case 6..<9:
                return Color(red: 1.0, green: 1.0, blue: 0.4)    // 6..9
            case 9..<12:
                return Color(red: 1.0, green: 1.0, blue: 0.2)    // 9..12
            case 12..<15:
                return Color(red: 1.0, green: 1.0, blue: 0.0)    // 12..15
            case 15..<18:
                return Color(red: 1.0, green: 0.8, blue: 0.0)    // 15..18
            case 18..<21:
                return Color(red: 1.0, green: 0.6, blue: 0.0)    // 18..21
            case 21..<24:
                return Color(red: 1.0, green: 0.4, blue: 0.0)    // 21..24
            case 24..<27:
                return Color(red: 1.0, green: 0.3, blue: 0.0)    // 24..27
            case 27..<30:
                return Color(red: 1.0, green: 0.15, blue: 0.0)   // 27..30
            case 30..<33:
                return Color(red: 1.0, green: 0.0, blue: 0.0)    // 30..33
            default:
                return Color(red: 1.0, green: 0.0, blue: 0.0)    // >= 33
            }
        }
        
        return LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
    }
    
}

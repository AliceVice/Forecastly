
import SwiftUI
import Charts


struct DailtyRow: View {
    
    let day: String
    let imageName: String
    let minTemp: Int
    let maxTemp: Int
    let temperatures: [Double]
    
    var body: some View {
        HStack(spacing: 0) {
            Text(day)
                .font(.headline)
                .frame(width: 50)
            
            Spacer()
            
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .scaledToFit()
                .font(.title)
                .frame(width: 50)
            
            Spacer()
            
            HStack(spacing: 6) {
                
                Text("\(minTemp) °C")
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .frame(width: 40)
                
                Rectangle()
                    .fill(
                        LinearGradient.temperatureGradient(for: temperatures)
                    )
                    .frame(width: 100, height: 3)
                    .padding(.horizontal)
                
                Text("\(maxTemp) °C")
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .frame(width: 40)
            }
        }
    }
}


#Preview {
    DailtyRow(
        day: "Thu",
        imageName: "cloud.fill",
        minTemp: 5,
        maxTemp: 12,
        temperatures: [1, 2, 3, 4, 5, 6,
                       7, 8, 7, 8, 9, 9,
                       10, 12, 12, 9, 10,
                       9, 7, 6, 4, 2, 1]
    )
}


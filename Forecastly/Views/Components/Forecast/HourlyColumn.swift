
import SwiftUI


struct HourlyColumn: View {
    
    let hour: String
    let imageName: String
    let temperature: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Text("\(hour)")
                .font(.headline)
            
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .font(.title)
            
            
            Text("\(temperature) °C")
                .font(.headline)
        }
        .padding()
    }
}


#Preview {
    HourlyColumn(hour: "6", imageName: "cloud.fill", temperature: 19)
}

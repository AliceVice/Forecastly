
import SwiftUI


struct CardView: View {
    
    let cardName: String
    let cardImageName: String?
    let value: String?
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text(cardName.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.top, 8)
            
            Divider()
            
            HStack(spacing: 8) {
                
                if let cardImageName {
                    Image(systemName: cardImageName)
                        .font(Font.system(size: 48))
                }
                
                if let value {
                    Text(value)
                        .minimumScaleFactor(0.7)
                        .lineLimit(2)
                        .font(.title)
                }
            }
            .frame(height: 80)
            .padding()
            
            Text(description)
                .minimumScaleFactor(0.7)
                .padding(.horizontal)
            
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 0.5)
        )
    }
}


#Preview {
    CardView(cardName: "Feels like", cardImageName: "drop", value: "19 °C", description: "Actual: 17 °C")
        .frame(width: 180, height: 180)
}


import SwiftUI


struct SomethingWentWrongView: View {
    
    let errorDescription: String
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.yellow)
                
                Text(errorDescription)
                    .font(.title2)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                PrimaryButton(title: "Try Again", color: .blue) {
                    retryAction()
                }
            }
            .padding()
            
            Spacer()
        }
    }
}


#Preview {
    SomethingWentWrongView(errorDescription: "Something went wrong.") {}
}

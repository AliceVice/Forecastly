
import SwiftUI


enum SheetState: CGFloat {
    case partiallyExpanded = 0.4   // 40% of the screen
    case expanded = 0.8            // 80% of the screen
    
    mutating func switchToNextState() {
        switch self {
        case .partiallyExpanded:
            self = .expanded
        case .expanded:
            self = .partiallyExpanded
        }
    }
}


struct SheetView<Content: View>: View {
    
    let content: Content
    @Binding private var sheetState: SheetState
    
    init(sheetState: Binding<SheetState>, @ViewBuilder content: () -> Content) {
        self._sheetState = sheetState
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundStyle(.gray)
                .frame(width: 50, height: 4)
                .clipShape(.capsule)
                .padding(.top, 10)
                .padding(.bottom, 5)
            
            Divider()
            
            content
            
            Spacer()
        }
        .frame(maxWidth: UIScreen.width)
        .frame(
            height: UIScreen.height * sheetState.rawValue
        )
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 30))
        .gesture(
            DragGesture()
                .onEnded{ value in
                    if value.translation.height < 0 {
                        sheetState = .expanded
                    } else if value.translation.height > 0 {
                        sheetState = .partiallyExpanded
                    }
                }
        )
        .animation(.interactiveSpring(duration: 0.5), value: sheetState)
    }
}


#Preview {
    
    Spacer()
    
    SheetView(sheetState: .constant(.partiallyExpanded)) {
        Text("Hello!")
        Text("Hello!")
        Text("Hello!")
    }
}



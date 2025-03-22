
import SwiftUI


extension UIWindow {
    
    /// Returns the current key window from the connected scenes.
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    
    /// Returns the screen associated with the current key window.
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
    
    /// The height of the current screen. Returns 0 in case if current screen is nil
    static var height: CGFloat {
        UIScreen.current?.bounds.height ?? 0
    }
    
    /// The width of the current screen. Returns 0 in case if current screen is nil
    static var width: CGFloat {
        UIScreen.current?.bounds.width ?? 0
    }
}

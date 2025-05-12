import WatchConnectivity
import SwiftUI

class WatchConnectivityManager: NSObject, ObservableObject {
    static let shared = WatchConnectivityManager()
    @Published var receivedImage: UIImage?
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    func sendMessage(_ message: [String: Any]) {
        guard WCSession.default.activationState == .activated else { return }
        
        WCSession.default.sendMessage(message, replyHandler: nil) { error in
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("Session activation failed with error: \(error.localizedDescription)")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        if let image = UIImage(data: messageData) {
            DispatchQueue.main.async {
                self.receivedImage = image
            }
        }
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle iOS-specific session events
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Handle iOS-specific session events
        WCSession.default.activate()
    }
    #endif
} 
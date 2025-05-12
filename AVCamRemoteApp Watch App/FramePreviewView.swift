import SwiftUI

struct FramePreviewView: View {
    @ObservedObject private var connectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        Group {
            if let image = connectivityManager.receivedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Image(systemName: "camera.viewfinder")
                        .font(.system(size: 40))
                        .foregroundColor(.gray)
                    Text("Waiting for frames...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

#Preview {
    FramePreviewView()
} 
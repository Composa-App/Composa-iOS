import SwiftUI
import AVFoundation

/// A monitoring-focused camera preview view for the selected camera device.
struct CameraMonitorView: View {
    let selectedDevice: AVCaptureDevice
    @State private var cameraModel = CameraModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Preview area
            PreviewContainer(camera: cameraModel) {
                CameraPreview(source: cameraModel.previewSource)
                    .ignoresSafeArea()
            }
            .overlay {
                StatusOverlayView(status: cameraModel.status)
            }
            
            // Controls overlay
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    Spacer()
                }
                .padding()
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(selectedDevice.localizedName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await cameraModel.startWith(device: selectedDevice)
                //cameraModel.startFrameCapture() // Start frame capture for Watch preview
            }
        }
        .onDisappear {
            //cameraModel.stopFrameCapture()
        }
    }
}

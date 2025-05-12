import SwiftUI

struct CameraConnectView: View {
  @Bindable var cameraModel: CameraModel

    var body: some View {
        ZStack {
            // Main content based on camera status
            switch cameraModel.status {
            case .unknown:
                // Show a searching/progress indicator
                ProgressView("Searching for devices...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear {
                        cameraModel.discoverDevices()
                    }

            case .failed:
                // Show a "No devices found" or error message
                VStack {
                    Text("No devices found or failed to start camera.")
                        .foregroundColor(.secondary)
                    Button("Retry") {
                        cameraModel.discoverDevices()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .running:
                // Show the camera monitor view
                CameraMonitorView(cameraModel: cameraModel)

            case .disconnected, .unauthorized, .interrupted:
                // Show the monitor view (if possible) with an overlay for the error/interruption
                //if let cameraModel = cameraModel/*.selectedDevice*/ {
                  CameraMonitorView(cameraModel: cameraModel)
                //}
                StatusOverlayView(status: cameraModel.status)
            }

            // Device selection modal (sheet)
        }
        .sheet(isPresented: $cameraModel.showDeviceSelectionModal) {
          CameraDeviceListView(
                devices: cameraModel.devices,
                onSelect: { device in
                    cameraModel.selectDevice(device)
                }
            )
        }
    }
}

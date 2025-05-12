import SwiftUI
import AVFoundation

/// Displays a list of available external cameras for selection.
struct CameraDeviceListView: View {
    let devices: [AVCaptureDevice]
    let onSelect: (AVCaptureDevice) -> Void

    var body: some View {
        List(devices, id: \.uniqueID) { device in
            Button(action: {
                onSelect(device)
            }) {
                VStack(alignment: .leading) {
                    Text(device.localizedName)
                        .font(.headline)
                    // ... other device info ...
                }
            }
        }
    }
}

//struct CameraDeviceListView: View {
//    @State private var devices: [AVCaptureDevice] = []
//    @State private var isLoading = true
//    @State private var selectedDevice: AVCaptureDevice?
//    @State private var navigateToMonitor = false
//    
//    private let deviceLookup = DeviceLookup()
//    
//    var body: some View {
//        NavigationStack {
//            Group {
//                if isLoading {
//                    ProgressView("Searching for cameras…")
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                } else if devices.isEmpty {
//                    Text("No external cameras found.")
//                        .foregroundColor(.secondary)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                } else {
//                  List(devices, id: \.uniqueID) { device in
//                        Button(action: {
//                            selectedDevice = device
//                            navigateToMonitor = true
//                        }) {
//                            VStack(alignment: .leading) {
//                                Text(device.localizedName)
//                                    .font(.headline)
//                                if device.position == .unspecified {
//                                    Text("External Camera")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                } else {
//                                    Text(device.position == .front ? "Front Camera" : "Back Camera")
//                                        .font(.subheadline)
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Select Camera")
//            .onAppear(perform: loadDevices)
//            .background(
//                NavigationLink(
//                    destination: Group {
//                        if let device = selectedDevice {
//                            CameraMonitorView(selectedDevice: device)
//                        }
//                    },
//                    isActive: $navigateToMonitor,
//                    label: { EmptyView() }
//                )
//                .hidden()
//            )
//        }
//    }
//    
//    private func loadDevices() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            let allDevices = deviceLookup.cameras
//            // Only show external cameras for now
//            let externalCameras = allDevices.filter { $0.deviceType == .external }
//            DispatchQueue.main.async {
//                self.devices = externalCameras
//                self.isLoading = false
//            }
//        }
//    }
//}

//#Preview {
//  CameraDeviceListView(devices: <#[AVCaptureDevice]#>, onSelect: <#(AVCaptureDevice) -> Void#>)
//}

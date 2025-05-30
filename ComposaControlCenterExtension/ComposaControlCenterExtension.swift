/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A Control Center extension for AVCam.
*/

import SwiftUI
import WidgetKit
import AppIntents

struct ComposaControlCenterExtension: ControlWidget {
    
    static var kind = "com.example.apple-samplecode.AVCam.AVCamControlCenterExtension.ControlButton"
    static var displayName: LocalizedStringResource = "Open AVCam"
    static var description: LocalizedStringResource = "Launch AVCam app."
    
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: ComposaControlCenterExtension.kind) {
            ControlWidgetButton(action: AVCamCaptureIntent()) {
                Label("Open AVCam", systemImage: "curlybraces")
            }
        }
        .displayName(ComposaControlCenterExtension.displayName)
        .description(ComposaControlCenterExtension.description)
    }
}

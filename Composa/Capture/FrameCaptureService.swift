import AVFoundation
import UIKit
import WatchConnectivity

class FrameCaptureService: NSObject {
    private let frameOutput = AVCaptureVideoDataOutput()
    private let frameQueue = DispatchQueue(label: "com.example.avcam.frameCapture")
    private var frameTimer: Timer?
    private var lastFrameTime: Date = .distantPast
    private let targetFrameRate: TimeInterval = 1.0 // 1 frame per second
    private let targetSize = CGSize(width: 160, height: 90) // Small size for Watch
    
    override init() {
        super.init()
        setupFrameOutput()
    }
    
    private func setupFrameOutput() {
        frameOutput.setSampleBufferDelegate(self, queue: frameQueue)
        frameOutput.alwaysDiscardsLateVideoFrames = true
    }
    
    func addToSession(_ session: AVCaptureSession) {
        if session.canAddOutput(frameOutput) {
            session.addOutput(frameOutput)
        }
    }
    
    func startFrameCapture() {
        frameTimer = Timer.scheduledTimer(withTimeInterval: targetFrameRate, repeats: true) { [weak self] _ in
            self?.captureFrame()
        }
    }
    
    func stopFrameCapture() {
        frameTimer?.invalidate()
        frameTimer = nil
    }
    
    private func captureFrame() {
        // This will be called by the timer, but actual frame capture happens in the delegate
    }
    
    private func processAndSendFrame(_ image: UIImage) {
        // Downscale the image
        let scaledImage = image.preparingThumbnail(of: targetSize) ?? image
        
        // Convert to JPEG with compression
        if let imageData = scaledImage.jpegData(compressionQuality: 0.5) {
            // Send to Watch
            if WCSession.default.activationState == .activated {
                WCSession.default.sendMessageData(imageData, replyHandler: nil) { error in
                    print("Error sending frame to Watch: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension FrameCaptureService: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Only process frames at our target rate
        let now = Date()
        guard now.timeIntervalSince(lastFrameTime) >= targetFrameRate else { return }
        lastFrameTime = now
        
        // Convert sample buffer to UIImage
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
        let image = UIImage(cgImage: cgImage)
        
        // Process and send the frame
        processAndSendFrame(image)
    }
} 
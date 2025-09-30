//
//  CameraService.swift
//  AI-Recognition
//
//  Created by Haya Alfakieh on 9/29/25.
//

import AVFoundation

final class CameraService: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let session = AVCaptureSession()
    var onFrame: ((CVPixelBuffer) -> Void)?
    
    private let videoQueue = DispatchQueue(label: "videoQueue")
    private(set) var currentPosition: AVCaptureDevice.Position = .back
    private var videeoOutput: AVCaptureVideoDataOutput!
    
    
    override init() {
        super.init()
        configureSession()
    }
    
    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .high
        
        
        guard
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition),
            let input = try? AVCaptureDeviceInput(device: device)
        else {
            print("camera not available")
            session.commitConfiguration()
                  return
            
        }
        session.addInput(input)
        
        
        let output = AVCaptureVideoDataOutput()
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: videoQueue)
        if session.canAddOutput(output) {
            session.addOutput(output)
            
        }
        
    
    }
}

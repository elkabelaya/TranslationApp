//
//  AVCameraRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import AVFAudio
import AVFoundation
import Vision
import Combine

final class AVCameraRepository: NSObject, CameraRepositoryProtocol {
    private let session: AVCaptureSession
    private let device: AVCaptureDevice?
    private let input:  AVCaptureDeviceInput?
    private let output: AVCaptureVideoDataOutput?
    var handle:((TextRecognizable) -> Void)?

    init(session: AVCaptureSession,
         device: AVCaptureDevice?,
         input: AVCaptureDeviceInput?,
         output: AVCaptureVideoDataOutput?) {
        self.session = session
        self.device = device
        self.input = input
        self.output = output
    }

    func start() async {
        if let input, let output, await Self.isAuthorized {
            session.beginConfiguration()
            if session.canAddInput(input) { session.addInput(input) }
            
            output.setSampleBufferDelegate(
                self,
                queue: DispatchQueue(label: "camera_queue")
            )
            if session.canAddOutput(output) { session.addOutput(output) }

            output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String:
                                     kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
            session.commitConfiguration()

            session.startRunning()
        }
    }
    
    func stop() async {
        if let input, let output {
            session.beginConfiguration()
            session.removeInput(input)
            session.removeOutput(output)
            session.commitConfiguration()
            session.stopRunning()
        }
    }
    
    func setTorch(on: Bool) async -> Bool {
        do {
            if let device, device.hasTorch {
                try device.lockForConfiguration()
                device.torchMode = on ? .on : .off
                device.unlockForConfiguration()
                return !on
            }
            return false
        } catch {
            return false
        }
    }

    static var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            return isAuthorized
        }
    }
}

extension AVCameraRepository: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        handle?(sampleBuffer)
    }
}


protocol VNObservationMapperProtocol: Sendable {
    func map(_ from: VNRecognizedTextObservation) -> TextObservation
}

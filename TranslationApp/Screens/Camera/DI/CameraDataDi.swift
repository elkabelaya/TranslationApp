//
//  CameraDataDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI
import AVFoundation

extension ServiceLocator {
    func diCameraData() throws {
        register(AVCaptureSession.self, AVCaptureSession())
        register((AVCaptureDevice?).self,
                 AVCaptureDevice.default(
                    .builtInWideAngleCamera,
                    for: .video,
                    position: .back
                 )
        )
        
        register((AVCaptureDeviceInput)?.self) {r in
            try? AVCaptureDeviceInput(device: r.resolve()!)
        }
        
        register(AVCaptureVideoDataOutput.self) {r in
            AVCaptureVideoDataOutput()
        }
        
        register(VNObservationMapperProtocol.self, VNObservationMapper())
        
        register(CameraRepositoryProtocol.self) {r in
            AVCameraRepository(
                session: r.resolve()!,
                device: r.resolve(),
                input: r.resolve(),
                output: r.resolve()
            )
        }
        
        register(ImagePickerRepositoryProtocol.self) {r in
            PHImagePickerRepository()
        }
        
        register(TextRecognizerRepositoryProtocol.self){r in
            VNTextRecognizerRepository(mapper: r.resolve()!)
        }
    }
}

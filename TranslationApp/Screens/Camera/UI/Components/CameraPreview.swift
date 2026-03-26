//
//  CameraPreview.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.03.2026.
//

import SwiftUI
import AVFoundation

fileprivate final class PreviewView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}

struct CameraPreview: UIViewRepresentable {
    var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = PreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

#Preview {
    CameraPreview(session: AVCaptureSession())
}

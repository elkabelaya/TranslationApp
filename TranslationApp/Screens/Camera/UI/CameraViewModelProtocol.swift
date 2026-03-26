//
//  CameraViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI
import AVFoundation
enum CameraViewState {
    case video(AVCaptureSession, Bool)
    case photo(UIImage)
    
}
protocol CameraViewModelProtocol: Observable {
    var previewImage: Image? { get }
    var state: CameraViewState{ get }
    var observedTexts: [TextObservation] { get }
    var isPicking: Bool { get set }
    
    func onThumbnailClick()
    func onActionClick()
    func onTorchClick()
    func onCameraClick()
    func onPickImage(image: UIImage)
}

//
//  MockCameraViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI
import AVFoundation

@Observable
final class MockCameraViewModel: CameraViewModelProtocol {
    
    
    init(
        state: CameraViewState,
         previewImage: Image? = nil,
         observedTexts: [TextObservation] = [],
        isPicking: Bool = false
    ) {
        self.state = state
        self.previewImage = previewImage
        self.observedTexts = observedTexts
        self.isPicking = isPicking
    }
    
    var isPicking: Bool
    var state: CameraViewState
    var previewImage: Image?
    var observedTexts: [TextObservation]
    
    func onThumbnailClick() {
        
    }
    
    func onActionClick(){
        
    }
    
    func onTorchClick(){
        
    }
    
    func onCameraClick(){
        
    }
    
    func onPickImage(image: UIImage){
        
    }
    
    func onBack() {
        
    }
}

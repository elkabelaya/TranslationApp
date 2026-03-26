//
//  CameraViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI
import AVFoundation
import Combine

@Observable
final class CameraViewModel: CameraViewModelProtocol {
    private let interactor: CameraInteractorProtocol
    private var videoSession: AVCaptureSession
    private var isTorchOn: Bool = false
    var state: CameraViewState
    var previewImage: Image?
    var isPicking: Bool = false
    var observedTexts: [TextObservation] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init(interactor: CameraInteractorProtocol,
         videoSession: AVCaptureSession) {
        self.interactor = interactor
        self.videoSession = videoSession
        self.state = .video(videoSession, false)
        setup()
    }
    
    private func setup() {
        interactor.lastImageInGallery(
            size: CGSize(
                width: AppDimens.Icon.m.rawValue,
                height: AppDimens.Icon.m.rawValue
            )
        )
        .sink {[weak self] receivedValue in
            if let receivedValue,
               let uiImage = UIImage(data: receivedValue) {
                self?.previewImage = Image(uiImage: uiImage)}
            else {
                self?.previewImage = nil
            }
        }
        .store(in: &cancellables)
        
        interactor.recognitions()
        .sink {[weak self] receivedValue in
            self?.observedTexts = receivedValue
        }
        .store(in: &cancellables)
    }
    
    func onThumbnailClick() {
        Task {
            if await interactor.canPickImage(){
                isPicking = true
                await interactor.stopVideo()
            }
        }
    }
    
    func onActionClick(){
        
    }
    
    func onTorchClick(){
        Task {
            isTorchOn = await interactor.setTorch(on: !isTorchOn)
            state = .video(videoSession, isTorchOn)
        }
    }
    
    func onCameraClick() {
        Task {
            let isTorchOn = self.isTorchOn ?
                            await interactor.setTorch(on: isTorchOn) :
                            false
            state = .video(videoSession, isTorchOn)
        }
    }
    
    func onPickImage(image: UIImage) {
        state = .photo(image)
        interactor.handlePicked(image: image)
    }
}

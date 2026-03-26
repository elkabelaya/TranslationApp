//
//  CameraInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import Combine
import Foundation


final class CameraInteractor: CameraInteractorProtocol {
    private var cameraRepository: CameraRepositoryProtocol
    private var imagePickerRepository: ImagePickerRepositoryProtocol
    private let recognizerRepository: TextRecognizerRepositoryProtocol
    
    init(cameraRepository: CameraRepositoryProtocol,
         imagePickerRepository: ImagePickerRepositoryProtocol,
         recognizerRepository: TextRecognizerRepositoryProtocol) {
        self.cameraRepository = cameraRepository
        self.imagePickerRepository = imagePickerRepository
        self.recognizerRepository = recognizerRepository
        self.cameraRepository.handle = recognizerRepository.recognize
    }
    
    func recognitions() -> PassthroughSubject<[TextObservation], Never> {
        recognizerRepository.recognizedTexts
    }
    
    func lastImageInGallery(size: CGSize)-> CurrentValueSubject<Data?, Never> {
        imagePickerRepository.thumbnailSize = size
        return imagePickerRepository.lastImageInGallery
    }
    
    func canPickImage() async -> Bool {
        await imagePickerRepository.isAuthorised()
    }
    
    func handlePicked(image: TextRecognizable) {
        recognizerRepository.recognize(in: image)
    }
    
    func startVideo() async {
        await cameraRepository.start()
    }
    
    func stopVideo() async {
        await cameraRepository.stop()
    }
    
    func setTorch(on: Bool) async -> Bool {
        await cameraRepository.setTorch(on: on)
    }
}

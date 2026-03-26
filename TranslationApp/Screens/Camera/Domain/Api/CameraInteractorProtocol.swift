//
//  CameraInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import Combine
import Foundation


protocol CameraInteractorProtocol {
    func lastImageInGallery(size: CGSize)-> CurrentValueSubject<Data?, Never>
    func recognitions() -> PassthroughSubject<[TextObservation], Never>
    func canPickImage() async -> Bool
    func handlePicked(image: TextRecognizable)
    func startVideo() async
    func stopVideo() async
    func setTorch(on: Bool) async -> Bool
}

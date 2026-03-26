//
//  CameraRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Combine

protocol CameraRepositoryProtocol {
    func start() async
    func stop() async
    func setTorch(on: Bool) async -> Bool
    var handle:((TextRecognizable) -> Void)? { get set }
}

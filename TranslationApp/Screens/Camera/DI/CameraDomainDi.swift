//
//  CameraDomainDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI

extension ServiceLocator {
    func diCameraDomain() throws {
        register(CameraInteractorProtocol.self) { r in
            return CameraInteractor(
                cameraRepository: r.resolve()!,
                imagePickerRepository: r.resolve()!,
                recognizerRepository: r.resolve()!
            )
        }
    }
}

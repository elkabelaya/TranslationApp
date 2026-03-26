//
//  CameraUiDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI

extension ServiceLocator {
    func diCameraUi() throws {
        register(CameraViewModelProtocol.self) { r in
            return CameraViewModel(interactor: r.resolve()!, videoSession: r.resolve()!)
        }
    }
}

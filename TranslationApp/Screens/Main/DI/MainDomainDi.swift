//
//  CommonDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 18.03.2026.
//

import SwiftData
import Foundation
import AVFAudio

extension ServiceLocator {
    func diMainDomain() throws {
        register(VoiceInteractorProtocol.self) { r in
            return CommonVoiceInteractor(
                recogniserRepository: r.resolve()!,
                synthesizerRepository: r.resolve()!,
                soundRepository: r.resolve()!
            )
        }
        register(MainFavoritesInteractorProtocol.self) { r in
            return MainFavoritesInteractor(
                repository: r.resolve()!
            )
        }
        register(MainShareInteractorProtocol.self) { r in
            return MainShareInteractor(
                copyRepository: r.resolve()!
            )
        }
    }
}

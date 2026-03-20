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
    func diCommonDomain() throws {
        register(VoiceInteractorProtocol.self) { r in
            return CommonVoiceInteractor(
                recogniserRepository: r.resolve()!,
                synthesizerRepository: r.resolve()!,
                soundRepository: r.resolve()!
            )
        }
        register(TranslateInteractorProtocol.self) { r in
            return TranslateInteractor(
                languagesRepository: r.resolve()!,
                translationRepository: r.resolve()!,
                settingsRpository: r.resolve()!,
                remoteIconsRepository: r.resolve()!,
                localIconsRepository: r.resolve()!,
                historyRepository: r.resolve()!
            )
        }
    }
}


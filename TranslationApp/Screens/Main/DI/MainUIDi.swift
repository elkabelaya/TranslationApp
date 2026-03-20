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
    func diMainUi() throws {
        register(MainViewModelProtocol.self) { r in
            return MainViewModel(
                translateIntractor: r.resolve()!,
                favoritesInteractor: r.resolve()!,
                voiceInteractor: r.resolve()!,
                shareInteractor: r.resolve()!
            )
        }
    }
}

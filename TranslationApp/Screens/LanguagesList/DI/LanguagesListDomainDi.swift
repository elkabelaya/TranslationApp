//
//  LanguagesListDomainDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diLanguagesListDomain() throws {
        register(LanguagesListInteractorProtocol.self) { r in
            return LanguagesListInteractor(
                languageRepository: r.resolve()!,
                settingsRepository: r.resolve()!
            )
        }
    }
}

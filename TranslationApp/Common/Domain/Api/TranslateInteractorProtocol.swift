//
//  TranslateInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

import Combine

protocol TranslateInteractorProtocol {
    
    func getIconPath(for: Language) async throws -> String
    func translate(text: String, from: Language, to: Language) async throws -> Translation?
    func selectedLanguages() -> CurrentValueSubject<
        (from: Language?, to: Language?),
        Never
    >
    func swap()
}

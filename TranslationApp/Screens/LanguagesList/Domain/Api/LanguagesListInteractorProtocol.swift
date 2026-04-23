//
//  LanguagesListInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//


protocol LanguagesListInteractorProtocol {
    func getLanguages(filter: String) async throws -> [Language]
    func saveLanguage(lng: Language, for: LanguageType) async
    func swap() async
}

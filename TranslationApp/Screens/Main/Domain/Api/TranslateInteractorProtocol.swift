//
//  TranslateInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

protocol TranslateInteractorProtocol {
    func getLanguages(filter: String) async throws -> [Language]
    func translate(text: String, from: Language, to: Language) async throws -> String
    func saveLanguages(from: Language?, to: Language?) async
    func savedLanguages() async  -> (from: Language?, to: Language?)
}

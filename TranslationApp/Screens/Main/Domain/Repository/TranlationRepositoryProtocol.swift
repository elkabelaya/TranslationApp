//
//  TranlationRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

protocol TranlationRepositoryProtocol {
    func get(from: LanguageCode, to: LanguageCode, text: String) async throws -> String
}

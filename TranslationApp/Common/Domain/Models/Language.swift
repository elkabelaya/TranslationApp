//
//  Language.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

typealias LanguageCode = String
struct Language: Equatable, Identifiable {
    let id: LanguageCode
    let name: String
}

enum LanguageType: Codable {
    case from
    case to
}

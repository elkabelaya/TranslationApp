//
//  SettingsRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

protocol SettingsRepositoryProtocol {
    func save(from : Language?, to: Language?)
    func restoreLanguages() -> (from: Language?, to: Language?)
}

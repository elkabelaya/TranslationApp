//
//  SettingsRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Combine

protocol SettingsRepositoryProtocol {
    var selectedLanguages: CurrentValueSubject<
        (from: Language?, to: Language?),Never> { get }
    func save(from : Language)
    func save(to: Language)
    func swapLanguages()
}

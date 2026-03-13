//
//  LocaleLanguageRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

import Foundation

protocol LocaleProvider {
    var locale: Locale.Type { get }
    var currentLocale: Locale { get }
}

final class SystemLocaleProvider: LocaleProvider {
    var locale: Locale.Type { Locale.self }
    var currentLocale: Locale { Locale.current }
}

final class LocaleLanguageRepository: LanguagesRepositoryProtocol {
    let localeProvider: LocaleProvider
    
    init(localeProvider: LocaleProvider) {
        self.localeProvider = localeProvider
    }
    
    func getList() -> [Language] {
        localeProvider.locale.LanguageCode.isoLanguageCodes
            .compactMap {
                if let code = $0.identifier(.alpha2),
                   code.count == 2,
                   let name = getName(for: code) {
                    return Language(id: code, name: name)
                }
                return nil
            }
    }
    
    func getName(for code: LanguageCode) -> String? {
        localeProvider.currentLocale.localizedString(forLanguageCode: code)
    }
}



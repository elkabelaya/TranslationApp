//
//  UserDefaultsSettingsRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Foundation

fileprivate enum UserDefaultsKeys: String {
    case languageFrom
    case languageTo
}

fileprivate extension UserDefaults {
    func set<V>(_ value: V?, forKey defaultName: UserDefaultsKeys) {
        self.set(value, forKey: defaultName.rawValue)
    }
    
    func object<V>(forKey defaultName: UserDefaultsKeys) -> V? {
        self.object(forKey: defaultName.rawValue) as? V
    }
}

final class UserDefaultsSettingsRepository: SettingsRepositoryProtocol {
    private let userDefaults: UserDefaults
    private let mapper: LanguageMapperProtocol
    private let coder: CoderProtocol
    
    init(userDefaults: UserDefaults,
         mapper: LanguageMapperProtocol,
         coder: CoderProtocol) {
        self.userDefaults = userDefaults
        self.mapper = mapper
        self.coder = coder
    }
    
    func save(from: Language?, to: Language?) {
        if let from {
            try? userDefaults.set(
                coder.encode(mapper.map(from: from)),
                forKey: .languageFrom
            )
        }
        if let to {
            userDefaults.set(
                try? coder.encode(mapper.map(from:to)),
                forKey: .languageTo
            )
        }
    }
    
    func restoreLanguages() -> (from: Language?, to: Language?) {
        var result: (from: Language?, to: Language?) = (from: nil, to: nil)
        if let fromData: Data = userDefaults.object(forKey: .languageFrom) {
            result.from = mapper.map(from: try! coder.decode(LanguageDto.self, from: fromData))
        }
        if let toData: Data = userDefaults.object(forKey: .languageTo) {
            result.to = mapper.map(from: try! coder.decode(LanguageDto.self, from: toData))
        }
        return result
    }
}

protocol LanguageMapperProtocol {
    func map(from: Language) -> LanguageDto
    func map(from: LanguageDto) -> Language
}





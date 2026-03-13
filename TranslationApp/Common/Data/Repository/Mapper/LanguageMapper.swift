//
//  LanguageMapper.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

final class LanguageMapper: LanguageMapperProtocol {
    func map(from: Language) -> LanguageDto {
        LanguageDto(id: from.id, name: from.name)
    }
    func map(from: LanguageDto) -> Language {
        Language(id: from.id, name: from.name)
    }
}

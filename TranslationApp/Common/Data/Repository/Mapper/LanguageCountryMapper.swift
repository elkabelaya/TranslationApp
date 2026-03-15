//
//  LanguageCountryMapper.swift
//  TranslationApp
//
//  Created by elka belaya  on 14.03.2026.
//

nonisolated final class LanguageCountryMapper: LanguageCountryMapperProtocol {
    //ISO 639-1 language codes  map to country codes ISO 3166-1 alpha-2
    func map(_ from: LanguageCode) -> CounryCodeDto {
        switch from {
        case "en": 
            return "gb"
        case "zh": 
            return "cn"
        case "ar": 
            return "sa"
        default:
            return from
        }
    }
    
    
}

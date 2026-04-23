//
//  LanguageMock.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

extension Language {
    static var mock: Language {
        Language(id: "ar", name: "Arabic")
    }
    
    static var otherMock: Language {
        Language(id: "ab", name: "Abkhazian")
    }
    
    static var mocks: [Language] { [mock, otherMock] }
}

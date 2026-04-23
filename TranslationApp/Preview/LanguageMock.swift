//
//  LanguageMock.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

extension Language {
    static var mock: Language {
        Language(id: "en", name: "English")
    }
    
    static var otherMock: Language {
        Language(id: "ru", name: "Spanish")
    }
    
    static var mocks: [Language] { [mock, otherMock] }
}

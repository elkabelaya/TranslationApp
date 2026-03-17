//
//  TranslationMock.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Foundation

extension Translation {
    static var mock: Translation {
        Translation(
            id: UUID(),
            fromCode: "en",
            fromText: "Hello",
            toCode: "es",
            toText: "Hola",
            isFavorite: false
        )
    }
    static var favoriteMock: Translation {
        Translation(
                id: UUID(),
                fromCode: "en",
                fromText: "Hello",
                toCode: "es",
                toText: "Hola",
                isFavorite: true
            )
    }
    static var mocks: [Translation] { [mock, favoriteMock] }
}

//
//  TranslationMapper.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Foundation

final class TranslationMapper: TranslationMapperProtocol {
    func map(_ from: FavoriteTranslation) -> Translation {
        Translation(fromCode: from.fromCode,
                            fromText: from.fromText,
                            toCode: from.toCode,
                            toText: from.toText
        )
    }
    
    func map(_ from: Translation) -> FavoriteTranslation {
        FavoriteTranslation(fromCode: from.fromCode,
                            fromText: from.fromText,
                            toCode: from.toCode,
                            toText: from.toText
        )
    }
}

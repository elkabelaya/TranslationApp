//
//  TranslationMapper.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Foundation

final class TranslationMapper: TranslationMapperProtocol {
    func map(_ from: SDTranslation) -> Translation {
        Translation(id:from.id,
                    fromCode: from.fromCode,
                    fromText: from.fromText,
                    toCode: from.toCode,
                    toText: from.toText,
                    isFavorite: from.isFavourite
        )
    }
    
    func map(_ from: Translation, inHistory: Bool) -> SDTranslation {
        SDTranslation(
            id: from.id,
            fromCode: from.fromCode,
            fromText: from.fromText,
            toCode: from.toCode,
            toText: from.toText,
            isFavourite:from.isFavorite,
            isInHistory: inHistory
        )
    }
}

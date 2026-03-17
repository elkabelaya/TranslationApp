//
//  Translation.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

import Foundation
struct Translation: Sendable {
    let id: UUID
    let fromCode: String
    let fromText: String
    let toCode: String
    let toText: String
    var isFavorite: Bool
}



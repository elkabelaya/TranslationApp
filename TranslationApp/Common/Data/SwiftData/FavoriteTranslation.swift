//
//  FavoriteLanguage.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

import SwiftData
import Foundation

@Model
final class FavoriteTranslation {
    var fromCode: String
    var fromText: String
    var toCode: String
    var toText: String
    
    init(fromCode: String, fromText: String, toCode: String, toText: String) {
        self.fromCode = fromCode
        self.fromText = fromText
        self.toCode = toCode
        self.toText = toText
    }
}

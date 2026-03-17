//
//  SchemaV100.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//
import SwiftData
import Foundation

enum SchemaV100: VersionedSchema {
    static let versionIdentifier: Schema.Version = .init(1, 0, 0)
    
    static var models: [any PersistentModel.Type] { [FavoriteTranslation.self] }
    
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
}

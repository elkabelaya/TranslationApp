//
//  SchemaV101.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//
import SwiftData
import Foundation

enum SchemaV101: VersionedSchema {
    static let versionIdentifier: Schema.Version = .init(1, 0, 1)
    
    static var models: [any PersistentModel.Type] { [FavoriteTranslation.self, SDTranslation.self] }
    
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
    
    @Model
    final class SDTranslation {
        @Attribute(.unique)
        var id: UUID
        var fromCode: String
        var fromText: String
        var toCode: String
        var toText: String
        var isFavourite: Bool = false
        var isInHistory: Bool = false
        
        init(fromCode: String, fromText: String, toCode: String, toText: String) {
            self.id = UUID()
            self.fromCode = fromCode
            self.fromText = fromText
            self.toCode = toCode
            self.toText = toText
            isFavourite = true
            isInHistory = false
        }
    }
}

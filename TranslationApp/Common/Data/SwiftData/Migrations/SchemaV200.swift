//
//  SchemaV101.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//
import SwiftData
import Foundation

enum SchemaV200: VersionedSchema {
    static let versionIdentifier: Schema.Version = .init(2, 0, 0)
    
    static var models: [any PersistentModel.Type] { [SDTranslation.self] }
    
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
        
        init(
            id: UUID,
            fromCode: String,
            fromText: String,
            toCode: String,
            toText: String,
            isFavourite: Bool,
            isInHistory: Bool) {
            self.id = id
            self.isFavourite = isFavourite
            self.isInHistory = isInHistory
            self.fromCode = fromCode
            self.fromText = fromText
            self.toCode = toCode
            self.toText = toText
        }
    }
}

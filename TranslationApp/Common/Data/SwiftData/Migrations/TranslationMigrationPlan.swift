//
//  TranslationMigrationPlan.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftData

enum TranslationMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [
            SchemaV100.self,
            SchemaV101.self,
            SchemaV200.self
        ]
      }

    static var stages: [MigrationStage] {
        [
            migrateV100toV101, migrateV101toV200
        ]
    }

    static let migrateV100toV101 = MigrationStage.custom(
        fromVersion: SchemaV100.self,
        toVersion: SchemaV101.self,
        willMigrate: { _ in
            print("test")
        },
        didMigrate: { context in
            let oldItems = try context.fetch(FetchDescriptor<SchemaV101.FavoriteTranslation>())
            for item in oldItems {
                context.insert(
                    SchemaV101.SDTranslation(
                        fromCode: item.fromCode,
                        fromText: item.fromText,
                        toCode: item.toCode,
                        toText: item.toText
                    )
                )
            }
            try? context.save()
        }
    )
    
    static let migrateV101toV200 = MigrationStage.lightweight(
        fromVersion: SchemaV101.self,
        toVersion: SchemaV200.self
    )
}

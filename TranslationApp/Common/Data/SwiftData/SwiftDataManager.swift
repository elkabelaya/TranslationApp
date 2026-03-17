//
//  SwiftDataManager.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//
import SwiftData

@MainActor
struct DatabaseManager {
    static func createCurrentModelContainer() throws -> ModelContainer {
        let schema = Schema(versionedSchema: CurrentSchema.self)
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        let container = try ModelContainer(
            for: schema,
            migrationPlan: TranslationMigrationPlan.self,
            configurations: [modelConfiguration]
        )
        
        return container
    }
}

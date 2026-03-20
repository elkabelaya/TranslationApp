//
//  TranslationApp.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import SwiftData

@main
struct TranslationApp: App {
    //let container: ModelContainer
    
    init() {
        do {
            //container = try DatabaseManager.createCurrentModelContainer()
        } catch {
            fatalError("Failed to initialize model container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AppView()
        }
        //.modelContainer(container)
    }
}

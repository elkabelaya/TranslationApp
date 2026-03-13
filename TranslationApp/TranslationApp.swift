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
    var body: some Scene {
        WindowGroup { 
            ContentView()
                
        }
        .modelContainer(for: FavoriteTranslation.self)
    }
}

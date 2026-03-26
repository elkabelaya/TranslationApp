//
//  TextObservation.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Foundation

struct TextObservation: Identifiable {
    let id = UUID()
    let text: String
    let boundingBox: CGRect
}

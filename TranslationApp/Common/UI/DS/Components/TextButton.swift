//
//  TextButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

struct TextButton: View {
    let key: String
    let font: Font
    let color: Color
    let action:() -> Void
    
    init(_ key: String,
         _ font: Font,
         _ color: Color,
         _ action: @escaping () -> Void) {
        self.key = key
        self.font = font
        self.color = color
        self.action = action
    }
    
    init(_ key: LocalizedStringResource,
         _ font: Font,
         _ color: Color,
         _ action: @escaping () -> Void) {
        self.key = String(localized: key)
        self.font = font
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(key)
                .appStyle(font, color)
        }
    }
 }

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    VStack(alignment: .leading, spacing: 8) {
        TextButton("test", .textXs, .appAccentBackground) {}
        TextButton("test", .titleM, .appAccentBackground) {}
    }
}

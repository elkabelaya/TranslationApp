//
//  IconTextButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import SwiftUI

struct IconTextButton: View {
    let icon: ImageResource
    let iconSize: AppDimens.Icon
    let key: String
    let font: Font
    let color: Color
    let action:() -> Void
    
    init(_ icon: ImageResource,
         _ iconSize: AppDimens.Icon,
         _ key: String,
         _ font: Font,
         _ color: Color,
         _ action: @escaping () -> Void) {
        self.icon = icon
        self.iconSize = iconSize
        self.key = key
        self.font = font
        self.color = color
        self.action = action
    }
    
    init(_ icon: ImageResource,
         _ iconSize: AppDimens.Icon,
         _ key: LocalizedStringResource,
         _ font: Font,
         _ color: Color,
         _ action: @escaping () -> Void) {
        self.icon = icon
        self.iconSize = iconSize
        self.key = String(localized: key)
        self.font = font
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: .xl) {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(color)
                    .size(iconSize)
                Text(key)
                    .appStyle(font, color)
            }
        }
    }
 }

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    VStack(alignment: .leading, spacing: 8) {
        IconTextButton(.icCopy, .s, "test", .textXs, .appAccentBackground) {}
        IconTextButton(.icCopy, .m, "test", .titleM, .appAccentBackground) {}
    }
}

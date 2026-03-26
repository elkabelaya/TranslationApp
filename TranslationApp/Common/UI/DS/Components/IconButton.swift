//
//  IconButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

struct IconButton: View {
    let icon: ImageResource
    let size: AppDimens.Icon
    let color: Color
    let action:() -> Void
    
    init(_ icon: ImageResource,
         _ size: AppDimens.Icon,
         _ color: Color,
         _ action: @escaping () -> Void) {
        self.icon = icon
        self.size = size
        self.color = color
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(icon)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(color)
                .size(size)
        }
    }
 }

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        IconButton(.icCopy, .s, .appAccentText){}
        IconButton(.icCopy, .m, .appSecondaryText){}
    }
}

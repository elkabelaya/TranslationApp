//
//  CircleIcon.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.03.2026.
//

import SwiftUI

struct CircleIcon: View {
    let size: AppDimens.CircleIcon
    let color: Color
    let borderColor: Color
    let action:() -> Void
    
    init(
         _ size: AppDimens.CircleIcon,
         _ color: Color,
         _ borderColor: Color,
         _ action: @escaping () -> Void) {
        self.size = size
        self.color = color
        self.borderColor = borderColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .stroke(
                    borderColor,
                    lineWidth: size.border()
                )
                .size(size)
            
        }
    }
 }

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        CircleIcon(
            .l,
            .appAccentText,
            .appTertiaryBackground
        ){}
        CircleIcon(
            .l,
            .appSecondaryText,
            .appAccentText
        ){}
    }
}

//
//  CardBackground.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

private struct CardBackground: ViewModifier {
     let radius: CGFloat
     func body(content: Content) -> some View {
        content
             .background(.appSecondaryBackground)
             .cornerRadius(radius)
             .shadow(
                color: Color(.appShadow), radius: 3, y: 1
             )
     }
 }

extension View {
    func cardBackground(corners: AppDimens.Corners) -> some View {
        modifier(CardBackground(radius: corners.rawValue))
    }
}

#Preview {
    VStack(spacing: 24) {
        Rectangle()
            .fill(.appSecondaryBackground)
            .frame(width: 200, height: 100)
            .cardBackground(corners: .xs)
        
        Rectangle()
            .fill(.appSecondaryBackground)
            .frame(width: 200, height: 100)
            .cardBackground(corners: .xxl)
    }
}

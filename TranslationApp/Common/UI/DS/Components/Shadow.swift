//
//  Shadow.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

fileprivate struct Shadow: ViewModifier {
    let y: CGFloat
     func body(content: Content) -> some View {
        content
             .shadow(
                color: Color(.appShadow), radius: 3, y: y
             )
     }
 }

extension View {
    public func downShadow() -> some View {
        modifier(Shadow(y: 1))
    }
    
    public func upShadow() -> some View {
        modifier(Shadow(y: -1))
    }
}


#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    HStack(spacing: 24) {
        Rectangle()
            .fill(.appSecondaryBackground)
            .frame(width: 100, height: 100)
            .downShadow()
        
        Rectangle()
            .fill(.appSecondaryBackground)
            .frame(width: 100, height: 100)
            .upShadow()
    }
}

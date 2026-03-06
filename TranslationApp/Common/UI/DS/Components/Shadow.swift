//
//  Shadow.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

private struct Shadow: ViewModifier {
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

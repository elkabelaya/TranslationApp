//
//  ConditionalViewExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 05.03.2026.
//
import SwiftUI

extension View {
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(content(self))
        } else {
            return AnyView(self)
        }
    }
    
    func iflet<Conditional,Content: View>(
        _ conditional: Conditional?,
        content: (Self, Conditional) -> Content
    ) -> some View {
        if let conditional {
            return AnyView(content(self, conditional))
        } else {
            return AnyView(self)
        }
    }
    
    func apply<Content: View>(transform: (Self) -> Content) -> some View {
        transform(self)
    }
}

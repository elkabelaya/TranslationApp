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
    
    func apply<Content: View>(transform: (Self) -> Content) -> some View {
        transform(self)
    }
}

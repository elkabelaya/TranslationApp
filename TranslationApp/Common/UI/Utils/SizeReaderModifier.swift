//
//  VisibleModifier.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

fileprivate struct VisibleModifier: ViewModifier {
    let condition: Bool
    func body(content: Content) -> some View {
        content
            .if(!condition) { view in
                view.hidden()
            }
    }
}

extension View {
    public func isVisible(_ condition: Bool) -> some View {
        modifier(VisibleModifier(condition: condition))
    }
}

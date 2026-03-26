//
//  ViewExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

private struct Pulse: ViewModifier {
    @State private var pulseValue = false
     func body(content: Content) -> some View {
        content
             .scaleEffect(pulseValue ? 1.2 : 1)
             .onAppear {
                 withAnimation(
                     Animation.easeInOut(duration: 0.5)
                         .repeatForever(autoreverses: true)
                 ) {
                     pulseValue.toggle()
                 }
             }
     }
 }

extension View {
    func pulse() -> some View {
        modifier(Pulse())
    }
}

#Preview {
    Circle()
        .size(100)
        .pulse()
}

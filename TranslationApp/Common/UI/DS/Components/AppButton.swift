//
//  AppButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle { .init() }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { .init() }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
            .font(.textM)
            .tracking(0.10)
            .lineSpacing(20)
            .foregroundStyle(.appOnAccentText)
            .background(.appAccentBackground)
            .cornerRadius(AppDimens.Corners.xxxl.rawValue)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24))
            .font(.textM)
            .tracking(0.10)
            .lineSpacing(20)
            .foregroundStyle(.appTertiaryText)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Button("Primary", action: {})
        .buttonStyle(.primary)
    Button("Secondary") {}
        .buttonStyle(.secondary)
}

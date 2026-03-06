//
//  TextExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension Text {
    func appStyle(_ font: Font, _ color: Color) -> some View {
        self
            .font(font)
            .foregroundStyle(color)
    }
}

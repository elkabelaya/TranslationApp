//
//  TextExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension Text {
    func appStyle(_ font: Font, _ color: Color) -> Self {
        self
            .font(font)
            .foregroundStyle(color)
    }
    
    func align() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//
//  VStackExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension VStack {
    init(alignment: HorizontalAlignment = .center,spacing: AppDimens.Paddings, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

extension HStack {
    init(alignment: VerticalAlignment = .center, spacing: AppDimens.Paddings, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

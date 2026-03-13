//
//  ViewExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension View {
    func paddings(_ top: AppDimens.Paddings,
                  _ leading: AppDimens.Paddings,
                  _ bottom: AppDimens.Paddings,
                  _ trailing: AppDimens.Paddings ) -> some View {
        self
            .padding(EdgeInsets(top: top.rawValue,
                                leading: leading.rawValue,
                                bottom: bottom.rawValue,
                                trailing: trailing.rawValue))
    }
    
    func cornerRadius(_ radius: AppDimens.Corners ) -> some View {
        self
            .cornerRadius(radius.rawValue)
    }
}

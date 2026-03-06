//
//  AppFonts.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

extension Font {
    private static let regular: String = "Roboto-Regular"
    private static let medium: String = "Roboto-Medium"
    
    static private func appFont(_ name: String, _ size: AppDimens.Font) -> Font {
        Font.custom(name, size: size.rawValue)
    }
    
    
    static func titleXs() -> Font { appFont(Self.medium, .xs)}
    static func titleS() -> Font { appFont(Self.medium, .s)}
    static var titleM = appFont(Self.medium, .m)
    static var titleL = appFont(Self.medium, .l)
    static var textXs = appFont(Self.regular, .xs)
    static var textS = appFont(Self.regular, .s)
    static var textM = appFont(Self.regular, .m)
}

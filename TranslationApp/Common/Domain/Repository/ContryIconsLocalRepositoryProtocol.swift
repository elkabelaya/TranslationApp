//
//  ContryIconsLocalRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 13.03.2026.
//

import Foundation

protocol ContryIconsLocalRepositoryProtocol {
    func hasIcon(lng: LanguageCode) async -> Bool
    func getIconPath(lng: LanguageCode) async -> String
    func save(iconData: Data, lng: LanguageCode) async throws-> Void
}

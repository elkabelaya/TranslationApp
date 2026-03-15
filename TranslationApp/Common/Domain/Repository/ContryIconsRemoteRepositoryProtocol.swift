//
//  ContryIconsRemoteRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 13.03.2026.
//

import Foundation

protocol ContryIconsRemoteRepositoryProtocol {
    func getImage(lng: LanguageCode) async throws -> Data
}

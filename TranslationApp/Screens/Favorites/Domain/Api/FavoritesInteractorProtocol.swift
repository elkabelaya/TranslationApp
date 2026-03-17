//
//  FavoritesInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine

protocol FavoritesInteractorProtocol {
    func getList() -> Publisher<[Translation], Never>

    func remove(translation: Translation)  async throws
}

//
//  FavoritesRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine

protocol FavoritesRepositoryProtocol {
    var itemsPublisher: Publisher<[Translation], Never> { get }
    func addToFavorites (_ translation: Translation)  async throws
    func removeFromFavorites(_ translation: Translation)  async throws
}

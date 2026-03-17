//
//  FavoritesInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine

final class FavoritesInteractor: FavoritesInteractorProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getList() -> Publisher<[Translation], Never> {
        repository.itemsPublisher
    }
    
    func remove(translation: Translation)  async throws {
        try await repository.removeFromFavorites(translation)
    }
}

//
//  MainFavoritesInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

final class MainFavoritesInteractor: MainFavoritesInteractorProtocol {
    private let repository: HistoryRepositoryProtocol
    
    init(repository: HistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleFavorites(translation: Translation)  async throws {
        if translation.isFavorite {
            try await repository.removeFromFavorites(translation)
        } else  {
            try await repository.addToFavorites(translation)
        }
    }
}

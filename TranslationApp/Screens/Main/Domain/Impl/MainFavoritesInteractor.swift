//
//  MainFavoritesInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

final class MainFavoritesInteractor: MainFavoritesInteractorProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleFavorites(translation: Translation)  async throws -> Bool {
        if try await repository.find(translation) != nil {
            try await repository.remove(translation)
            return false
        } else  {
            try await repository.add(translation)
            return true
        }
    }
}

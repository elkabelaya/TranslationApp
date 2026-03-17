//
//  HistoryInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine


final class HistoryInteractor: HistoryInteractorProtocol {
    private let repository: HistoryRepositoryProtocol
    
    init(repository: HistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func getList() -> Publisher<[Translation], Never> {
        repository.itemsPublisher
    }
    
    func clear()  async throws {
        try await repository.clearHistory()
    }
    
    func toggleFavorite(_ translation: Translation)  async throws {
        if translation.isFavorite {
            try await repository.removeFromFavorites(translation)
        } else {
            try await repository.addToFavorites(translation)
        }
    }
}

//
//  FavoritesViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI
import Combine

@Observable
final class FavoritesViewModel: FavoritesViewModelProtocol {
    let favoritesInteractor: FavoritesInteractorProtocol
    var items: [Translation] = []
    var cancellables: Set<AnyCancellable> = []
    
    init(favoritesInteractor: FavoritesInteractorProtocol) {
        self.favoritesInteractor = favoritesInteractor
        favoritesInteractor.getList()
            .sink{[weak self] receiveValue in
                self?.items = receiveValue
            }
            .store(in: &cancellables)
    }
    
    func onFavoriteClick(item: Translation) {
        Task {
            try await favoritesInteractor.remove(translation: item)
        }
    }
    
    func onBack() {
        
    }
    
}

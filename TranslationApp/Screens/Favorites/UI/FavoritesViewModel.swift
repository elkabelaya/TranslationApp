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
    private let favoritesInteractor: FavoritesInteractorProtocol
    private let router: AppRouterProtocol
    var items: [Translation] = []
    var cancellables: Set<AnyCancellable> = []
    
    init(favoritesInteractor: FavoritesInteractorProtocol,
         router: AppRouterProtocol) {
        self.favoritesInteractor = favoritesInteractor
        self.router = router
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
        router.showMain()
    }
    
}

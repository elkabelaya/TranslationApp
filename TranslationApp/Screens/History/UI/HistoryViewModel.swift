//
//  HistoryViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftUI
import Combine

@Observable
final class HistoryViewModel: HistoryViewModelProtocol {
    private let historyInteractor: HistoryInteractorProtocol
    private let router: AppRouterProtocol
    var items: [Translation] = []
    var cancellables: Set<AnyCancellable> = []
    init(historyInteractor: HistoryInteractorProtocol,
         router: AppRouterProtocol) {
        self.historyInteractor = historyInteractor
        self.router = router
        self.historyInteractor.getList()
            .sink{[weak self] receiveValue in
                self?.items = receiveValue
            }
            .store(in: &cancellables)
    }
    
    func onFavoriteClick(item: Translation) {
        Task {
            try await  historyInteractor.toggleFavorite(item)
        }
    }
    
    func onClearClick() {
        Task {
            try await historyInteractor.clear()
        }
    }
    
    func onBack() {
        router.showMain()
    }
}

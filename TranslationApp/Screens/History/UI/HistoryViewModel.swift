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
    var items: [Translation] = []
    var cancellables: Set<AnyCancellable> = []
    init(historyInteractor: HistoryInteractorProtocol) {
        self.historyInteractor = historyInteractor
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
        
    }
}

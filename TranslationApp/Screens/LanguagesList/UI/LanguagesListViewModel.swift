//
//  LanguagesListViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI
import Combine

@Observable
final class LanguagesListViewModel: LanguagesListViewModelProtocol {
    private let interactor: LanguagesListInteractorProtocol
    private let router: AppRouterProtocol
    private var filterPublisher = CurrentValueSubject<String, Never>("")
    private var cancellables: Set<AnyCancellable> = []
    private var type: LanguageType

    var filter: String = "" {
        didSet {
            filterPublisher.send(filter)
        }
    }
    var languages: [Language] = []
    
    init(type: LanguageType,
         interactor: LanguagesListInteractorProtocol,
         router: AppRouterProtocol
    ) {
        self.type = type
        self.interactor = interactor
        self.router = router
        setup()
    }
    
    private func setup() {
        filterPublisher
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] receiveValue in
                self?.getLanguages()
            }
            .store(in: &cancellables)
    }
    
    func onSelectLanguage (_ lng: Language) {
        Task { [weak self]  in
            guard let self else { return }
            await interactor.saveLanguage(lng: lng, for: type)
            router.dismiss()
        }
    }
    
    private func getLanguages() {
        Task { [weak self]  in
            guard let self else { return }
            languages = (try? await interactor.getLanguages(filter: filter)) ?? []
        }
    }
}

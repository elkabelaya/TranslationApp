//
//  LanguagesViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import Observation
import Combine
import SwiftUI


@Observable
class LanguagesViewModel: LanguagesViewModelProtocol {
    let translateIntractor: TranslateInteractorProtocol
    let router: AppRouterProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    var fromLng: Language? {
        didSet {
            resetIfChanged(oldValue, fromLng)
            if let fromLng {
                Task {
                    fromIconPath = try await translateIntractor.getIconPath(for: fromLng)
                }
            }
        }
    }
    
    var toLng: Language? {
        didSet {
            resetIfChanged(oldValue, toLng)
            if let toLng {
                Task {
                    toIconPath = try await translateIntractor.getIconPath(for: toLng)
                }
            }
        }
    }
    
    var fromIconPath: String?
    var toIconPath: String?
    
    init(translateIntractor: TranslateInteractorProtocol,
         router: AppRouterProtocol){
        self.translateIntractor = translateIntractor
        self.router = router
        setup()
    }
    
    private func setup() {
        translateIntractor.selectedLanguages()
            .sink {receiveValue in
                self.fromLng = receiveValue.from
                self.toLng = receiveValue.to
            }
            .store(in: &cancellables)
    }
    
    func onLngFromClick () {
        Task {
            router.showLanguagesList(type: .from)
        }
    }
    
    func onLngToClick (){
        Task {
            router.showLanguagesList(type: .to)
        }
        
    }
    
    func onSwapClick (){
        withAnimation {
            translateIntractor.swap()
        }
    }
    
    func resetIfChanged<T:Equatable>(_ old: T, _ new: T) {
        if old != new {
            refresh()
        }
    }
    
    func refresh() {
        fatalError("must be implemented in inheriters")
    }
    
}

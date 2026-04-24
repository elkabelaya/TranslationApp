//
//  MenuViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

@Observable
final class MenuViewModel: MenuViewModelProtocol {
    var version: String?
    
    private let interactor: MenuInteractorProtocol
    private let router: AppRouterProtocol
    
    init(interactor: MenuInteractorProtocol,
         router: AppRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }

    
    func onShareClick() {
        router.showShare(text: "Some url")
    }
    
    func onRateClick() {
        router.showRate()
    }
    
    func onPolicyClick() {
        router.showPolicy()
    }
    
    func onFeedbackClick() {
        router.showFeedback()
    }
}

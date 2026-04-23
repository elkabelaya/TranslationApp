//
//  AppViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

final class AppViewModel: AppViewModelProtocol {
    var chatView: AnyView
    var favouriteView: AnyView
    var historyView: AnyView
    var mainView: AnyView
    
    var presentingTab: AppTabs {
        get { router.presentingTab }
        set { router.presentingTab = newValue}
    }
    
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
        
        chatView = router.tab(tabbing: AppTabs.chat)
        favouriteView = router.tab(tabbing: AppTabs.favourite)
        historyView = router.tab(tabbing: AppTabs.history)
        mainView = router.tab(tabbing: AppTabs.main)
   }

    func tab(tabbing: AppTabs) -> AnyView {
        AnyView(router.tab(tabbing: tabbing)
            .isVisible(router.presentingTab == tabbing)
        )
    }
}

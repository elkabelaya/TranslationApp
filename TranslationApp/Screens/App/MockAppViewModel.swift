//
//  MockAppViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

final class MockAppViewModel: AppViewModelProtocol {
    var chatView: AnyView = AnyView(Text("chatView"))
    var favouriteView: AnyView = AnyView(Text("favouriteView"))
    var historyView: AnyView = AnyView(Text("historyView"))
    var mainView: AnyView = AnyView(Text("mainView"))
    
    var presentingTab: AppTabs {
        get { router.presentingTab }
        set { router.presentingTab = newValue}
    }
    
    var router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
   }
}

//
//  ContentView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit





struct AppView: View  {
    @State var viewModel: AppViewModelProtocol
    
    var body: some View {
        ZStack {
            viewModel.chatView
                .isVisible(viewModel.presentingTab == AppTabs.chat)
            viewModel.favouriteView
                .isVisible(viewModel.presentingTab == AppTabs.favourite)
            viewModel.historyView
                .isVisible(viewModel.presentingTab == AppTabs.history)
            viewModel.mainView
                .isVisible(
                    viewModel.presentingTab == AppTabs.main ||
                    viewModel.presentingTab == AppTabs.camera
                )
        }
        .tabbar(selectedTab: $viewModel.presentingTab,
                items: [
                    TabItem(type: .icon,
                            title: .App.tabChat,
                            icon: .tabChat,
                            tab: AppTabs.chat),
                    TabItem(type: .icon,
                            title: .App.tabCamera,
                            icon: .tabCamera,
                            tab: AppTabs.camera),
                    TabItem(type: .filledIcon,
                            title: .App.tabMain,
                            icon: .icTranslate,
                            tab: AppTabs.main),
                    TabItem(type: .icon,
                            title: .App.tabHistory,
                            icon: .tabHistory,
                            tab: AppTabs.history),
                    TabItem(type: .icon,
                            title: .App.tabFavorites,
                            icon: .tabFavorites,
                            tab: AppTabs.favourite),
                ]
        )
        .router(viewModel.router)
        .navigationStack(viewModel.router)
    }
}

#Preview {
    AppView(
        viewModel: MockAppViewModel(
            router: AppRouter(serviceLocator: ServiceLocator.mock)
        )
    )
}

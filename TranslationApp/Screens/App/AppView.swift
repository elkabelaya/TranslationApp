//
//  ContentView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

enum Tabs: Int {
    case chat
    case camera
    case main
    case history
    case favourite
}

struct AppView: View {
    @State var selectedTab: Int = Tabs.main.rawValue
    let serviceLocator: ServiceLocator = .init()
    init() {
        do {
            try serviceLocator.diCommon()
            try serviceLocator.diMain()
        } catch {
            print(error)
        }
    }
    var body: some View {
        ZStack {
            switch selectedTab {
            case Tabs.main.rawValue:
                MainView(
                    viewModel: serviceLocator.resolve()!
                )
            case Tabs.history.rawValue:
                HistoryView(
                    viewModel: HistoryViewModel(
                        historyInteractor: HistoryInteractor(
                            repository: SwiftDataHistoryRepository(
                                context : serviceLocator.resolve()!,
                                mapper: TranslationMapper()
                            )
                        )
                    )
                )
            case Tabs.favourite.rawValue:
                FavoritesView(
                    viewModel: FavoritesViewModel(
                        favoritesInteractor: FavoritesInteractor(
                            repository: SwiftDataFavoritesRepository(
                                context : serviceLocator.resolve()!,
                                mapper: TranslationMapper()
                            )
                        )
                    )
                )
            default:
                Text("TODO")
            }
        }
        .tabbar(selectedIndex: $selectedTab,
                items: [
                    TabItem(type: .icon,
                            title: .App.tabChat,
                                    icon: .tabChat),
                    TabItem(type: .icon,
                            title: .App.tabCamera,
                                    icon: .tabCamera),
                    TabItem(type: .filledIcon,
                            title: .App.tabMain,
                                icon: .icTranslate),
                    TabItem(type: .icon,
                            title: .App.tabHistory,
                            icon: .tabHistory),
                    TabItem(type: .icon,
                            title: .App.tabFavorites,
                                    icon: .tabFavorites)
                ]
        )
    }
}

#Preview {
    AppView()
}

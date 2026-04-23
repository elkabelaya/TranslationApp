//
//  MainRouter.swift
//  TranslationApp
//
//  Created by elka belaya  on 22.04.2026.
//

import SwiftUI
import Combine


enum AppRoutes: Routable {
    var id: Self { self }
    case lngList(type: LanguageType)
    case share(text: String)
    case camera
}

enum AppTabs: Tabbable {
    case chat
    case camera
    case main
    case history
    case favourite
}

@Observable
final class AppRouter: Router<AppRoutes>, @MainActor AppRouterProtocol {
    var presentingTab: AppTabs = AppTabs.main {
        didSet {
            if presentingTab == .camera {
                DispatchQueue.main.async{[weak self] in //async is critical!
                    self?.showCamera()
                }
            }
        }
    }
    private let serviceLocator: ServiceLocator
    
    init(serviceLocator: ServiceLocator) {
        self.serviceLocator = serviceLocator
    }

    override func navigation(routing: AppRoutes) -> AnyView {
        AnyView(getView(routing: routing))
    }
    
    override func modal(routing: AppRoutes, rootPresented: Binding<Bool>) -> AnyView  {
        AnyView(getView(routing: routing))
    }
    
    func tab(tabbing: AppTabs) -> AnyView {
        AnyView(getView(tabbing: tabbing))
    }
    
    func changeTab(_ tab: AppTabs) {
        presentingTab = tab
    }
}

extension AppRouter {
    func showLanguagesList(type: LanguageType) {
        presentSheet(.lngList(type: type))
    }
    
    func showShare(text: String) {
        presentSheet(.share(text: text))
    }
    
    func showCamera() {
        navigateTo(.camera)
    }
    
    func showMain() {
        popToRoot()
        changeTab(.main)
    }
    
    func showHistory() {
        changeTab(.history)
    }
    
    func showFavorite() {
        changeTab(.favourite)
    }
}

extension AppRouter {
    @ViewBuilder
    func getView(routing: AppRoutes) -> any View {
        switch routing {
        case .lngList(let type):
            LanguagesListView(viewModel: serviceLocator.resolve(param: type)!)
        case .camera:
            CameraView(viewModel: serviceLocator.resolve()!)
        case .share(text: let text):
            ActivityViewController(activityItems: [text])
        }
    }
    
    @ViewBuilder
    func getView(tabbing: AppTabs) -> any View {
        switch tabbing {
        case .camera:
            EmptyView()
        case .chat:
            EmptyView()
        case .favourite:
            FavoritesView(
                viewModel: FavoritesViewModel(
                    favoritesInteractor: FavoritesInteractor(
                        repository: SwiftDataFavoritesRepository(
                            context : serviceLocator.resolve()!,
                            mapper: TranslationMapper()
                        )
                    ),
                    router: serviceLocator.resolve()!
                )
            )
        case .history:
            HistoryView(
                viewModel: HistoryViewModel(
                    historyInteractor: HistoryInteractor(
                        repository: SwiftDataHistoryRepository(
                            context : serviceLocator.resolve()!,
                            mapper: TranslationMapper()
                        )
                    ),
                    router: serviceLocator.resolve()!
                )
            )
        case .main:
            MainView(viewModel: serviceLocator.resolve()!)
        }
    }
}

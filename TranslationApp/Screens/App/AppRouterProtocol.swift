//
//  AppRouterProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 22.04.2026.
//

import SwiftUI
import Combine

protocol AppRouterProtocol: Router<AppRoutes>, TabberProtocol where Tabbing == AppTabs {
    func showLanguagesList(type: LanguageType)
    func showShare(text: String)
    func showCamera()
    func showMain()
    func showHistory()
    func showFavorite()
    func showMenu()
    func showRate()
    func showPolicy()
    func showFeedback()
}

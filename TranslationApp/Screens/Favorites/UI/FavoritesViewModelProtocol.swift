//
//  FavoritesViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

protocol FavoritesViewModelProtocol: Observable {
    var items: [Translation] { get set }
    func onFavoriteClick(item: Translation)
    func onBack()
}

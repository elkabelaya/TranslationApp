//
//  MockFavoritesViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

@Observable
final class MockFavoritesViewModel: FavoritesViewModelProtocol {
    var items: [Translation]
    init(items: [Translation]) {
        self.items = items
    }
    
    
    func onFavoriteClick(item: Translation){}
    func onBack(){}
}

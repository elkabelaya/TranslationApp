//
//  MockHistoryViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftUI

@Observable
final class MockHistoryViewModel: HistoryViewModelProtocol {
    var items: [Translation] = []
    
    func onFavoriteClick(item: Translation) {
        
    }
    
    func onClearClick() {
        
    }
    
    func onBack() {
        
    }
    
}

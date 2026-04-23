//
//  MockLanguagesListViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

@Observable
final class MockLanguagesListViewModel: LanguagesListViewModelProtocol {
    var filter: String = ""
    
    let languages: [Language] = Language.mocks
    
    func onSelectLanguage(_ lng: Language) {
        
    }
    
}

//
//  MockLanguagesViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import Observation


@Observable
class MockLanguagesViewModel: LanguagesViewModelProtocol {
    var fromLng: Language?
    var toLng: Language?
    var fromIconPath: String?
    
    var toIconPath: String?
    
    init(fromLng: Language?,
         toLng: Language?) {
        self.fromLng = fromLng
        self.toLng = toLng
    }
    
    func onLngFromClick() {

    }
    
    func onLngToClick() {
    }
    
    func onSwapClick() {
    }
}

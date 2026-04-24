//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI



@Observable
final class MockMainViewModel: MockLanguagesViewModel, MainViewModelProtocol {

    
    
    var toast: ToastModel? 
    
    func onToCopyClick () {
        
    }
    func onToShareClick () {
        
    }
    func onToFavoriteClick() {
    
    }
    
    
    func onFromSpeakerClick() {
    }
    
    func onToSpeakerClick() {
    }
    
    func onFromCloseClick() {
    }
    
    func onMicrophoneClick() {
    }
    
    func onTranslateClick() {
    }
    
    
    
    func onSpeakerClick() {
    }
    
    func onMenuClick() {
    }

    var fromText: String
    var toText: String
    var isFavorite: Bool = false
    var isListening: Bool = false
    
    init(fromLng: Language?,
         toLng: Language?,
         fromText: String,
         toText: String,
         isFavorite: Bool = false,
         isListening: Bool = false,
    ) {
        
        self.fromText = fromText
        self.toText = toText
        self.isFavorite = isFavorite
        self.isListening = isListening
        super.init(fromLng: fromLng, toLng: toLng)
    }
}

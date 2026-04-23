//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

@Observable
final class MockMainViewModel: MainViewModelProtocol {
    var fromIconPath: String?
    
    var toIconPath: String?
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
    
    func onLngFromClick() {

    }
    
    func onLngToClick() {
    }
    
    func onSwapClick() {
    }
    
    func onSpeakerClick() {
    }
    
    var fromLng: Language?
    var toLng: Language?
    var fromText: String
    var toText: String
    var showSheet: Bool = false
    var isFavorite: Bool = false
    var isListening: Bool = false
    
    init(fromLng: Language?,
         toLng: Language?,
         fromText: String,
         toText: String,
         isFavorite: Bool = false,
         isListening: Bool = false,
    ) {
        self.fromLng = fromLng
        self.toLng = toLng
        self.fromText = fromText
        self.toText = toText
        self.isFavorite = isFavorite
        self.isListening = isListening
    }
}

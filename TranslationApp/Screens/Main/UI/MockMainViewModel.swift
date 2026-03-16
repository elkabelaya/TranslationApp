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
    
    func onSelectLanguage(_ lng: Language) {

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
    var filter: String = ""
    var languages: [Language] = []
    var bottomSheet: MainBottomSheet?
    var isFavorite: Bool = false
    var isListening: Bool = false
    
    init(fromLng: Language?,
         toLng: Language?,
         fromText: String,
         toText: String,
         isFavorite: Bool = false,
         isListening: Bool = false,
         bottomSheet: MainBottomSheet? = nil,
         languages:[Language] = [.init(id: "0", name: "English"),
                                 .init(id: "1", name:"Spanish")]
    ) {
        self.fromLng = fromLng
        self.toLng = toLng
        self.fromText = fromText
        self.toText = toText
        self.isFavorite = isFavorite
        self.isListening = isListening
        self.bottomSheet = bottomSheet
        self.languages = languages
        
    }
}

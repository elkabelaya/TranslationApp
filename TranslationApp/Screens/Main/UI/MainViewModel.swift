//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import Combine



@Observable
final class MainViewModel: LanguagesViewModel, MainViewModelProtocol {
    let favoritesInteractor: MainFavoritesInteractorProtocol
    let voiceInteractor: VoiceInteractorProtocol
    let shareInteractor: MainShareInteractorProtocol
    private var currentTranslation: Translation?
    var fromText: String = "" {didSet {resetIfChanged(oldValue, fromText)}}
    var toText: String {
        get {
            currentTranslation?.toText ?? ""
        }
    }
    var isFavorite: Bool {
        get {
            currentTranslation?.isFavorite ?? false
        }
    }
    var isListening: Bool = false
    var toast: ToastModel?

    init(translateIntractor: TranslateInteractorProtocol,
         favoritesInteractor: MainFavoritesInteractorProtocol,
         voiceInteractor: VoiceInteractorProtocol,
         shareInteractor: MainShareInteractorProtocol,
         router: AppRouterProtocol){
        self.favoritesInteractor = favoritesInteractor
        self.voiceInteractor = voiceInteractor
        self.shareInteractor = shareInteractor
        super.init(translateIntractor: translateIntractor,
                   router: router)
    }
    
    override func refresh() {
        currentTranslation = nil
        
    }
    
    func onFromSpeakerClick() {
        Task {
            if let fromLng, !fromText.isEmpty {
                try await voiceInteractor.speak(text: fromText, language: fromLng)
            }
        }
    }
    
    func onToSpeakerClick() {
        Task {
            if let toLng, !toText.isEmpty {
                try await voiceInteractor.speak(text: toText, language: toLng)
            }
        }
    }
    
    func onFromCloseClick() {
        clearTexts()
    }
    
    func onMicrophoneClick() {
        isListening = true
        clearTexts()
        
        Task {
            if let fromLng {
                do {
                    await voiceInteractor.notify()
                    for try await item in await voiceInteractor.listen(language: fromLng) {
                        print(item)
                        self.fromText = item
                    }
                    await voiceInteractor.notify()
                    isListening = false
                } catch {
                    
                }
            }
            
        }
    }
    
    func onTranslateClick() {
        Task {
            if let fromLng,
               let toLng {
                do {
                    currentTranslation = try await translateIntractor.translate(
                        text: fromText,
                        from: fromLng,
                        to: toLng
                    )
                } catch {
                    //TODO
                    print(error)
                }
            }
            
        }
    }
    
    func onToFavoriteClick () {
        Task {
            if let currentTranslation {
                try await favoritesInteractor.toggleFavorites(
                    translation: currentTranslation
                )
                self.currentTranslation?.isFavorite.toggle()
            }
        }
    }
    
    
    func onToCopyClick () {
        Task {
            await shareInteractor.copy(string: toText)
            toast = ToastModel(message: .Main.copiedToast)
        }
    }
    
    func onToShareClick () {
        router.showShare(text: toText)
    }
    
    func onMenuClick () {
        router.showMenu()
    }
    
    private func clearTexts() {
        fromText = ""
    }
}

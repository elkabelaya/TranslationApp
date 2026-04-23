//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import Combine



@Observable
final class MainViewModel: MainViewModelProtocol {
    let translateIntractor: TranslateInteractorProtocol
    let favoritesInteractor: MainFavoritesInteractorProtocol
    let voiceInteractor: VoiceInteractorProtocol
    let shareInteractor: MainShareInteractorProtocol
    let router: AppRouterProtocol

    private var currentTranslation: Translation?
    private var cancellables: Set<AnyCancellable> = []

    var fromLng: Language? {
        didSet {
            resetIfChanged(oldValue, fromLng)
            if let fromLng {
                Task {
                    fromIconPath = try await translateIntractor.getIconPath(for: fromLng)
                }
            }
        }
    }
    
    var toLng: Language? {
        didSet {
            resetIfChanged(oldValue, toLng)
            if let toLng {
                Task {
                    toIconPath = try await translateIntractor.getIconPath(for: toLng)
                }
            }
        }
    }
    
    var fromIconPath: String?
    var toIconPath: String?
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
    
    private func resetIfChanged<T:Equatable>(_ old: T, _ new: T) {
        if old != new {
            currentTranslation = nil
        }
    }
    init(translateIntractor: TranslateInteractorProtocol,
         favoritesInteractor: MainFavoritesInteractorProtocol,
         voiceInteractor: VoiceInteractorProtocol,
         shareInteractor: MainShareInteractorProtocol,
         router: AppRouterProtocol){
        self.translateIntractor = translateIntractor
        self.favoritesInteractor = favoritesInteractor
        self.voiceInteractor = voiceInteractor
        self.shareInteractor = shareInteractor
        self.router = router
        setup()
    }
    
    private func setup() {
        translateIntractor.selectedLanguages()
            .sink {receiveValue in
                self.fromLng = receiveValue.from
                self.toLng = receiveValue.to
            }
            .store(in: &cancellables)
    }
    
    

    func onLngFromClick () {
        Task {
            router.showLanguagesList(type: .from)
        }
    }
    
    func onLngToClick (){
        Task {
            router.showLanguagesList(type: .to)
        }
        
    }
    
    func onSwapClick (){
        translateIntractor.swap()
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
    
    private func clearTexts() {
        fromText = ""
    }
}

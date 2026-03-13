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
    
    private var cancellables: Set<AnyCancellable> = []
    private var filterPublisher = CurrentValueSubject<String, Never>("")
    private enum FromToLanguage {
        case from
        case to
    }
    private var selectingLanguage: FromToLanguage? = nil {
        didSet {showSheet = selectingLanguage != nil}
    }
    
    var filter: String = "" {didSet {filterPublisher.send(filter)}}
    var languages: [Language] = []
    var showSheet: Bool = false {didSet {if !showSheet {filter = ""} }}
    
    var fromLng: Language?
    var toLng: Language?
    var fromText: String = ""
    var toText: String = ""
    var isFavorite: Bool = false
    var isListening: Bool = false
    
    init(translateIntractor: TranslateInteractorProtocol,
         favoritesInteractor: MainFavoritesInteractorProtocol,
         voiceInteractor: VoiceInteractorProtocol){
        self.translateIntractor = translateIntractor
        self.favoritesInteractor = favoritesInteractor
        self.voiceInteractor = voiceInteractor
        setup()
    }
    
    private func setup() {
        Task {
            (fromLng, toLng) = await translateIntractor.savedLanguages()
        }
        filterPublisher
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .sink { [weak self] receiveValue in
                self?.getLanguages()
            }
            .store(in: &cancellables)
    }
    
    private func getLanguages() {
        Task { [weak self]  in
            guard let self else { return }
            languages = (try? await translateIntractor.getLanguages(filter: filter)) ?? []
        }
    }

    func onLngFromClick () {
        Task {
            getLanguages()
            selectingLanguage = .from
        }
    }
    
    func onLngToClick (){
        Task {
            getLanguages()
            selectingLanguage = .to
        }
        
    }
    
    func onSwapClick (){
        let tempFromLng = fromLng
        fromLng = toLng
        toLng = tempFromLng
        fromText = toText
        toText = ""
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
                    toText = try await translateIntractor.translate(
                        text: fromText,
                        from: fromLng,
                        to: toLng
                    )
                } catch {
                    toText = "test"
                    print(error)
                }
            }
            
        }
    }
    
    func onSelectLanguage(_ lng: Language) {
        switch selectingLanguage {
        case .from:
            fromLng = lng
        case .to:
            toLng = lng
        default:
            break
        }
        selectingLanguage = nil
        
        Task {
            await translateIntractor.saveLanguages(from: fromLng, to: toLng)
        }
    }
    
    func onToFavoriteClick () {
        Task {
            if let fromLng,
               let toLng,
               !fromText.isEmpty,
               !toText.isEmpty {
                isFavorite = try await favoritesInteractor.toggleFavorites(
                    translation: Translation(
                        fromCode: fromLng.id,
                        fromText: fromText,
                        toCode: toLng.id,
                        toText: toText
                    )
                )
            }
        }
    }
    
    private func clearTexts() {
        fromText = ""
        toText = ""
    }
}

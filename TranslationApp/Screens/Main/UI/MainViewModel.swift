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
    
    private var cancellables: Set<AnyCancellable> = []
    private var filterPublisher = CurrentValueSubject<String, Never>("")
    private enum FromToLanguage {
        case from
        case to
    }
    private var selectingLanguage: FromToLanguage? = nil
    private var currentTranslation: Translation?

    var filter: String = "" {
        didSet {
            filterPublisher.send(filter)
        }
    }
    var languages: [Language] = []
    var showSheet: Bool = false
    var bottomSheet: MainBottomSheet? {
        didSet {
            if bottomSheet == nil {
                filter = ""
            }
            showSheet = bottomSheet != nil
        }
    }
    
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
         shareInteractor: MainShareInteractorProtocol){
        self.translateIntractor = translateIntractor
        self.favoritesInteractor = favoritesInteractor
        self.voiceInteractor = voiceInteractor
        self.shareInteractor = shareInteractor
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
            bottomSheet = .languages
        }
    }
    
    func onLngToClick (){
        Task {
            getLanguages()
            selectingLanguage = .to
            bottomSheet = .languages
        }
        
    }
    
    func onSwapClick (){
        let tempFromLng = fromLng
        let tempFromIconPath = fromIconPath
        fromLng = toLng
        toLng = tempFromLng
        fromText = toText
        fromIconPath = toIconPath
        toIconPath = tempFromIconPath
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
        bottomSheet = nil
        Task {
            await translateIntractor.saveLanguages(from: fromLng, to: toLng)
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
        bottomSheet = .share(toText)
    }
    
    private func clearTexts() {
        fromText = ""
    }
}

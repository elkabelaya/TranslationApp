//
//  MainViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

enum MainBottomSheet:  Equatable {
    
    // TODO move to navigation layer
    case languages
    case share(String)
    //var id: UUID { UUID() }
}

protocol MainViewModelProtocol: Observable {
    var fromLng: Language? {get}
    var toLng: Language? { get }
    var fromIconPath: String? {get}
    var toIconPath: String? {get}
    var fromText: String { get set }
    var toText: String { get }
    var filter: String { get set }
    var languages: [Language] { get }
    var showSheet: Bool { get set }
    var bottomSheet: MainBottomSheet? { get set }
    var isFavorite: Bool { get }
    var isListening: Bool { get }
    var toast: ToastModel? { get set }
    func onLngFromClick ()
    func onLngToClick ()
    func onSwapClick ()
    func onFromSpeakerClick ()
    func onToSpeakerClick ()
    func onFromCloseClick ()
    func onMicrophoneClick ()
    func onTranslateClick ()
    func onSelectLanguage (_ lng: Language)
    func onToFavoriteClick ()
    func onToCopyClick ()
    func onToShareClick ()
    
}

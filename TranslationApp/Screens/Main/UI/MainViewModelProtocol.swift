//
//  MainViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

protocol MainViewModelProtocol: Observable {
    var fromLng: Language? {get}
    var toLng: Language? { get }
    var fromText: String { get set }
    var toText: String { get }
    var filter: String { get set }
    var languages: [Language] { get }
    var showSheet: Bool { get set }
    var isFavorite: Bool { get }
    var isListening: Bool { get }
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
    
}

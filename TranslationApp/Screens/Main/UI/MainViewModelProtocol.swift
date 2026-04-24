//
//  MainViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI



protocol MainViewModelProtocol: LanguagesViewModelProtocol {
    var fromText: String { get set }
    var toText: String { get }
    var isFavorite: Bool { get }
    var isListening: Bool { get }
    var toast: ToastModel? { get set }
    
    func onFromSpeakerClick ()
    func onToSpeakerClick ()
    func onFromCloseClick ()
    func onMicrophoneClick ()
    func onTranslateClick ()
    func onToFavoriteClick ()
    func onToCopyClick ()
    func onToShareClick ()
    func onMenuClick ()
    
}

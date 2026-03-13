//
//  TextToSpeachRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 09.03.2026.
//

protocol SpeechSynthesizerRepositoryProtocol {
    func speak(_ text: String, lng: LanguageCode) async
}

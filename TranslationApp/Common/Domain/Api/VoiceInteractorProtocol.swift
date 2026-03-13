//
//  VoiceInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 09.03.2026.
//
import Combine
protocol VoiceInteractorProtocol {
    func speak(text: String, language: Language) async throws
    func listen(language: Language) async -> AsyncThrowingStream<String, Error>
    func notify() async 
}

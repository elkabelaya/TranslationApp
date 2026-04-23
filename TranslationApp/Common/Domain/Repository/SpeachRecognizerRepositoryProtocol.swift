//
//  SpeachRecognizerProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 05.03.2026.
//
import Combine

protocol SpeachRecognizerRepositoryProtocol {
    func startStreaming(
        lng: LanguageCode
    ) -> AsyncThrowingStream<String, Error>
    func stop() async throws
}

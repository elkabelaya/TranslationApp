//
//  SpeachRecognizerProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 05.03.2026.
//
import Combine

class SpeachRecognizer: SpeachRecognizerProtocol {
    var result: CurrentValueSubject<String, Never> = .init("")
    func start() {
        
    }
    func stop() {
        
    }
}

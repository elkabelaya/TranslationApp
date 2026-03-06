//
//  SpeachRecognizerProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 05.03.2026.
//
import Combine

protocol SpeachRecognizerProtocol {
    var result: CurrentValueSubject<String, Never> { get }
    func start()
    func stop()
}

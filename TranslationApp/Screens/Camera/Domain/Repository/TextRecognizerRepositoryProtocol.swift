//
//  TextRecognizerRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Combine
typealias TextRecognizable = Any
protocol TextRecognizerRepositoryProtocol {
    func setLanguage(_ language: LanguageCode)
    var recognizedTexts: PassthroughSubject<[TextObservation], Never> { get }
    func recognize(in data: TextRecognizable)
}

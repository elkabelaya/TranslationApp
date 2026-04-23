//
//  LanguagesListViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

protocol LanguagesListViewModelProtocol: Observable {
    var filter: String { get set }
    var languages: [Language] { get }
    func onSelectLanguage (_ lng: Language)
}

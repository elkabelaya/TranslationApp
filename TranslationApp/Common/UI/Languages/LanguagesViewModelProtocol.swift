//
//  LanguagesViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import Observation


protocol LanguagesViewModelProtocol: Observable {
    var fromLng: Language? {get}
    var toLng: Language? { get }
    var fromIconPath: String? {get}
    var toIconPath: String? {get}
    
    func onLngFromClick ()
    func onLngToClick ()
    func onSwapClick ()
}

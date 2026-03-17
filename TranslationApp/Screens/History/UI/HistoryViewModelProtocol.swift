//
//  HistoryViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftUI

protocol HistoryViewModelProtocol: Observable {
    var items: [Translation] { get set }
    func onFavoriteClick(item: Translation)
    func onClearClick()
    func onBack()
}

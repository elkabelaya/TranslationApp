//
//  HistoryInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import Combine


protocol HistoryInteractorProtocol {
    func getList() -> Publisher<[Translation], Never>
    func clear()  async throws
    func toggleFavorite(_ translation: Translation)  async throws
}

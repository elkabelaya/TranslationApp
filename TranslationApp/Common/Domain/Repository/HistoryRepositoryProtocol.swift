//
//  HistoryRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//
import Combine

protocol HistoryRepositoryProtocol {
    var itemsPublisher: Publisher<[Translation], Never> { get }
     func addToHistory (_ translation: Translation)  async throws
    func addToFavorites (_ translation: Translation)  async throws
    func removeFromFavorites(_ translation: Translation)  async throws
    func clearHistory() async throws
}


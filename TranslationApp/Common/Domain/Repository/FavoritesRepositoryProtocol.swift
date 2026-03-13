//
//  LanguagesRepositoryProtocol.swift
//  FavoritesRepositoryProtocol
//
//  Created by elka belaya  on 08.03.2026.
//
import Combine

protocol FavoritesRepositoryProtocol {
    func getList() async throws -> [Translation]
    func add (_ translation: Translation)  async throws
    func remove(_ translation: Translation)  async throws
    func find(_ translation: Translation) async throws  -> Translation? 
}

//
//  LanguagesRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//
import Combine

protocol LanguagesRepositoryProtocol {
    func getList() -> [Language]
}

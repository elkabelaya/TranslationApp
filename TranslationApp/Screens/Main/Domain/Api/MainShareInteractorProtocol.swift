//
//  MainShareInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

protocol MainShareInteractorProtocol {
    func copy(string: String) async
    func share(string: String) async
}

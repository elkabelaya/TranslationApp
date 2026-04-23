//
//  LanguagesListUiDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diLanguagesListUi() throws {
        register(LanguagesListViewModelProtocol.self, param: LanguageType.self) { r, param in
            return LanguagesListViewModel(
                type: param,
                interactor: r.resolve()!,
                router: r.resolve()!
            )
        }
    }
}

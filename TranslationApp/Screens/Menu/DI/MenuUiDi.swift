//
//  MenuUiDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diMenuUi() throws {
        register(MenuViewModelProtocol.self) { r in
            return MenuViewModel(interactor: r.resolve()!, router: r.resolve()!)
        }
    }
}

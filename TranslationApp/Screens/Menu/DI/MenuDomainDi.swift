//
//  MenuDomainDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diMenuDomain() throws {
        register(MenuInteractorProtocol.self) { r in
            return MenuInteractor()
        }
    }
}

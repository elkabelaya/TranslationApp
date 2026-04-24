//
//  MenuDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diMenu() throws {
        try diMenuData()
        try diMenuDomain()
        try diMenuUi()
    }
}

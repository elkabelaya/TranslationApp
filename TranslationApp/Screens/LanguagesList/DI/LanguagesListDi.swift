//
//  LanguagesListDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

extension ServiceLocator {
    func diLanguagesList() throws {
        try diLanguagesListData()
        try diLanguagesListDomain()
        try diLanguagesListUi()
    }
}

//
//  CommonDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 18.03.2026.
//

import SwiftData
import Foundation
import AVFAudio

extension ServiceLocator {
    func diMain() throws {
        try diMainDomain()
        try diMainUi()
    }
}

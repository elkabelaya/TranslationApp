//
//  CameraDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 20.03.2026.
//

import SwiftUI

extension ServiceLocator {
    func diCamera() throws {
        try diCameraData()
        try diCameraDomain()
        try diCameraUi()
    }
}

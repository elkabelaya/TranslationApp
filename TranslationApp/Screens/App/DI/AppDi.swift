//
//  AppDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.03.2026.
//

import SwiftData
import Foundation
import AVFAudio

extension ServiceLocator {
    func diApp() throws {
        register(AppRouter.self, AppRouter(serviceLocator: self))
        register(AppRouterProtocol.self) { r in
            let router: AppRouter = r.resolve()!
            return router
        }
        register(AppViewModelProtocol.self) { r in
            AppViewModel(router: r.resolve()!)
        }
    }
}

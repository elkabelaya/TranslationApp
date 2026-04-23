//
//  ServiceLocatorMock.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

extension ServiceLocator {
    static var mock: ServiceLocator {
        let locator = ServiceLocator()
        locator.di()
        return locator
    }
}

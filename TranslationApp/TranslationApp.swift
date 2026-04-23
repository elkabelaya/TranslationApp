//
//  TranslationApp.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import SwiftData

@main
struct TranslationApp: App {
    let serviceLocator: ServiceLocator = .init()
    init() {
        serviceLocator.di()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(serviceLocator: serviceLocator)
        }
    }
}

struct RootView: View  {
    @State var appViewModel: AppViewModelProtocol
    init(serviceLocator: ServiceLocator) {
        appViewModel = serviceLocator.resolve()!
    }
    
    var body: some View {
        AppView(viewModel: appViewModel)
    }
}

extension ServiceLocator {
    func di() {
        try? diApp()
        try? diCommon()
        try? diMain()
        try? diCamera()
        try? diLanguagesList()
    }
}

#Preview {
    return RootView(serviceLocator: ServiceLocator.mock)
}

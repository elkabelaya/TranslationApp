//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

@Observable
final class MockMainViewModel: MainViewModelProtocol {
    var fromLng: String
    var toLng: String
    var fromText: String
    var toText: String
    
    init(fromLng: String, toLng: String, fromText: String, toText: String) {
        self.fromLng = fromLng
        self.toLng = toLng
        self.fromText = fromText
        self.toText = toText
    }
}

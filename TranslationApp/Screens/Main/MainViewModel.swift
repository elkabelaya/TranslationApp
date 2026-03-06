//
//  MainViewModel.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

@Observable
final class MainViewModel: MainViewModelProtocol {
    var fromLng: String  = ""
    var toLng: String = ""
    var fromText: String = ""
    var toText: String = ""
}

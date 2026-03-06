//
//  MainViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

protocol MainViewModelProtocol: Observable {
    var fromLng: String {get set}
    var toLng: String { get }
    var fromText: String { get set }
    var toText: String { get set }
}

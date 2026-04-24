//
//  MenuViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

protocol MenuViewModelProtocol: Observable {
    var version: String? { get }
    func onShareClick()
    func onRateClick()
    func onPolicyClick()
    func onFeedbackClick()
}

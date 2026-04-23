//
//  AppViewModelProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//
import SwiftUI

protocol AppViewModelProtocol: Observable {
    var presentingTab: AppTabs { get set }
    var router: AppRouter { get }
    var chatView: AnyView { get }
    var favouriteView: AnyView { get }
    var historyView: AnyView { get }
    var mainView: AnyView { get }
}

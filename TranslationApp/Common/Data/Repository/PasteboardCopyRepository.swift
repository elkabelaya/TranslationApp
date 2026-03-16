//
//  PasteboardCopyRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

import Foundation
import UIKit
final class PasteboardCopyRepository: CopyRepositoryProtocol {
    let pasteboard: UIPasteboard
    
    init(pasteboard: UIPasteboard) {
        self.pasteboard = pasteboard
    }
    
    
    func copy(_ text: String) {
        pasteboard.string = text
    }
}

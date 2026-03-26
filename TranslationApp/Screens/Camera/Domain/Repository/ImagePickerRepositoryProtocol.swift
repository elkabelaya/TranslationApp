//
//  ImagePickerRepositoryProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Combine
import Foundation

protocol ImagePickerRepositoryProtocol {
    var lastImageInGallery: CurrentValueSubject<Data?, Never> { get }
    func isAuthorised() async -> Bool
    var thumbnailSize: CGSize? { get set }
    var handle:((TextRecognizable) -> Void)? { get set }
}

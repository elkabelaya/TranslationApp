//
//  FileContryIconsLocalRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

import Foundation
actor FileContryIconsLocalRepository: ContryIconsLocalRepositoryProtocol {
    
    private let files: FilesProtocol
    private let ext: FileConstants.FileExtensions
    
    init(files: FilesProtocol, ext: FileConstants.FileExtensions) {
        self.files = files
        self.ext = ext
    }
    
    func hasIcon(lng: LanguageCode) async -> Bool {
        await files.exists(name: lng, ext: ext)
    }
    
    func getIconPath(lng: LanguageCode) async -> String {
        await files.getUrl(name: lng, ext: ext).absoluteString
    }
    
    func save(iconData: Data, lng: LanguageCode) async throws {
        try await files.save(data: iconData, name: lng, ext: ext)
    }
}

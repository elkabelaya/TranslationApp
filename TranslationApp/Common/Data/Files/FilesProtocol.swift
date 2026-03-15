//
//  FilesProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//
import Foundation

protocol FilesProtocol: Sendable {
    func exists(name: String, ext: FileConstants.FileExtensions) -> Bool
    func save(data: Data, name: String, ext: FileConstants.FileExtensions) async throws
    func getUrl(name: String, ext: FileConstants.FileExtensions) -> URL
}

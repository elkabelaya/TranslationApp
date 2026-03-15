//
//  Files.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

import Foundation

final class Files: FilesProtocol {
    private let fileManager: FileManager
    private let directory: String
    
    init(fileManager: FileManager, directory: FileConstants.FileDirectories) {
        self.fileManager = fileManager
        self.directory = directory.rawValue
    }
    
    func exists(name: String, ext: FileConstants.FileExtensions) -> Bool {
        fileManager.fileExists(atPath: getUrl(name: name, ext: ext).path)
    }
    
    func save(data: Data, name: String, ext: FileConstants.FileExtensions) async throws {
        try createDirectoryIfNeeded()
        try data.write(to: getUrl(name: name, ext: ext))
    }
    
    func getUrl(name: String, ext: FileConstants.FileExtensions) -> URL {
        getDirectory().appendingPathComponent("\(name).\(ext)")
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getDirectory() -> URL {
        getDocumentsDirectory().appendingPathComponent(directory)
    }
    
    private func createDirectoryIfNeeded() throws {
        if !fileManager.fileExists(atPath: getDirectory().path) {
            try fileManager.createDirectory(
                at: getDirectory(),
                withIntermediateDirectories: true,
                attributes: nil)
            
        }
    }
}


//
//  SwiftDataFavoritesRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftData
import Foundation
import Combine

final class SwiftDataFavoritesRepository: ListContextObserverBase<Translation>,
                                          FavoritesRepositoryProtocol {
    private let mapper: TranslationMapperProtocol

    init(context: ModelContext,
         mapper: TranslationMapperProtocol) {
        self.mapper = mapper
        super.init(context: context)
    }
    
    override func updateListItems() async throws -> [Translation] {
        try await updateFavorites()
    }
    
    private func updateFavorites() async throws -> [Translation] {
        let descriptor = FetchDescriptor<SDTranslation>(
            predicate: #Predicate { $0.isFavourite == true },
            sortBy: [SortDescriptor(\.id, order: .reverse)]
        )
        return try context.fetch(descriptor)
            .map{mapper.map($0)}
    }
    
    func addToFavorites (_ translation: Translation)  async throws {
        if let sdTranslation = await find(translation) {
            sdTranslation.isFavourite = true
            try context.save()
        }
    }
    
    func removeFromFavorites(_ translation: Translation)  async throws {
        if let item = await find(translation) {
            item.isFavourite = false
            try await removeIfOrphan(item)
            try context.save()
        }
    }
    
    func removeIfOrphan(_ translation: SDTranslation) async throws {
        if translation.isFavourite == false && translation.isInHistory == false {
            context.delete(translation)
        }
    }
    
    private func find(_ translation: Translation) async  -> SDTranslation? {
        do {
            let id = translation.id
            let predicate = #Predicate<SDTranslation> { item in
                item.id == id
            }
            
            var descriptor = FetchDescriptor<SDTranslation>(
                predicate: predicate
            )
            descriptor.fetchLimit = 1
            let result = try context.fetch(descriptor)
            return try context.fetch(descriptor).first
        } catch {
            print(error)
            return nil
        }
    }
}


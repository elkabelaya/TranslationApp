//
//  SwiftDataFavoritesRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

import SwiftData
import Foundation

final class SwiftDataHistoryRepository: ListContextObserverBase<Translation>,
                                        HistoryRepositoryProtocol {
    private let mapper: TranslationMapperProtocol

    init(context: ModelContext,
         mapper: TranslationMapperProtocol) {
        self.mapper = mapper
        super.init(context: context)
    }
    
    override func updateListItems() async throws -> [Translation] {
        try await updateHistory()
    }
    
    private func updateHistory() async throws -> [Translation] {
        let descriptor = FetchDescriptor<SDTranslation>(
            predicate: #Predicate { $0.isInHistory == true },
            sortBy: [SortDescriptor(\.id, order: .reverse)]
        )
        return try context.fetch(descriptor)
            .map{mapper.map($0)}
    }
    
    func addToHistory (_ translation: Translation) async throws {
        do {
            context.insert(mapper.map(translation, inHistory: true))
            try context.save()
        } catch {
            print(error)
        }
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
    
    func clearHistory() async throws {
        let predicate = #Predicate<SDTranslation> { item in
            item.isInHistory == true
        }
        let descriptor = FetchDescriptor<SDTranslation>(
            predicate: predicate
        )
        let itemsToDelete = try context.fetch(descriptor)
        
        for item in itemsToDelete {
            item.isInHistory = false
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

protocol TranslationMapperProtocol {
    func map(_ from: SDTranslation) -> Translation
    func map(_ from: Translation, inHistory: Bool) -> SDTranslation
}


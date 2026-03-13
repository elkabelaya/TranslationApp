//
//  SwiftDataFavoritesRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 08.03.2026.
//

import SwiftData
import Foundation

final class SwiftDataFavoritesRepository: FavoritesRepositoryProtocol {
    private let context: ModelContext
    private let mapper: TranslationMapperProtocol
    
    init(context: ModelContext,
         mapper: TranslationMapperProtocol) {
        self.context = context
        self.mapper = mapper
    }
    
    func getList() async throws  -> [Translation] {
        let descriptor = FetchDescriptor<FavoriteTranslation>(sortBy: [SortDescriptor(\.id, order: .reverse)])
        return try context.fetch(descriptor)
            .map{mapper.map($0)}
    }
    
    func add(_ translation: Translation) async throws {
        context.insert(mapper.map(translation))
        try context.save()
    }
    
    func remove(_ translation: Translation) async throws {
        context.delete(mapper.map(translation))
        try context.save()
    }
    
    func find(_ translation: Translation) async throws  -> Translation? {
        let fromCode = translation.fromCode
        let toCode = translation.toCode
        let fromText = translation.fromText
        let toText = translation.toText
        let predicate = #Predicate<FavoriteTranslation> { item in
            item.fromCode == fromCode &&
            item.toCode == toCode &&
            item.fromText == fromText &&
            item.toText == toText
            
            
        }
        
        
        let descriptor = FetchDescriptor<FavoriteTranslation>(
            predicate: predicate
        )
        if let translation = try context.fetch(descriptor).first {
            return mapper.map(translation)
        }
        
        return nil
    }
}

protocol TranslationMapperProtocol {
    func map(_ from: FavoriteTranslation) -> Translation
    func map(_ from: Translation) -> FavoriteTranslation
}


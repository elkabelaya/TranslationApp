//
//  TranslationSessionRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

import Translation
final class TranslationSessionRepository: TranlationRepositoryProtocol {
    let mapper: LngMapperProtocol
    init(mapper: any LngMapperProtocol) {
        self.mapper = mapper
    }
    func get(from: LanguageCode, to: LanguageCode, text: String) async throws -> String {
        let session: TranslationSession = .init(
            installedSource: mapper.map(code: from),
            target: mapper.map(code: to)
        )
        return try await session.translate(text).targetText
    }
}

protocol LngMapperProtocol {
    func map(code: LanguageCode) -> Locale.Language
}

class LngMapper: LngMapperProtocol {
    func map(code: LanguageCode) -> Locale.Language {
        Locale.Language(identifier: code)
    }
}

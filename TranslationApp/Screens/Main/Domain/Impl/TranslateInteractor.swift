//
//  TranslateInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

import Foundation

final class TranslateInteractor: TranslateInteractorProtocol {
    let languagesRepository: LanguagesRepositoryProtocol
    let translationRepository: TranlationRepositoryProtocol
    let settingsRpository: SettingsRepositoryProtocol
    let remoteIconsRepository: ContryIconsRemoteRepositoryProtocol
    let localIconsRepository: ContryIconsLocalRepositoryProtocol
    let historyRepository: HistoryRepositoryProtocol

    
    init(languagesRepository: LanguagesRepositoryProtocol,
         translationRepository: TranlationRepositoryProtocol,
         settingsRpository: SettingsRepositoryProtocol,
         remoteIconsRepository: ContryIconsRemoteRepositoryProtocol,
         localIconsRepository: ContryIconsLocalRepositoryProtocol,
         historyRepository: HistoryRepositoryProtocol) {
        self.languagesRepository = languagesRepository
        self.translationRepository = translationRepository
        self.settingsRpository = settingsRpository
        self.remoteIconsRepository = remoteIconsRepository
        self.localIconsRepository = localIconsRepository
        self.historyRepository = historyRepository
    }
    
    func getLanguages(filter: String) async throws -> [Language] {
        return languagesRepository.getList().filter {
            filter.isEmpty ||
            $0.name.lowercased().contains(filter.lowercased())
        }
    }
    
    func getIconPath(for lng: Language) async throws -> String {
        if await !localIconsRepository.hasIcon(lng: lng.id) {
            try await localIconsRepository.save(
                iconData: try await remoteIconsRepository.getImage(lng: lng.id),
                lng: lng.id)
        }
        
        return await localIconsRepository.getIconPath(lng: lng.id)
    }
    
    func translate(text: String, from: Language, to: Language) async throws -> Translation? {
        let translated: String? = "test"
        //TODO
        if !text.isEmpty,
//           let translated = try? await translationRepository.get(
//            from: from.id,
//            to: to.id,
//            text: text
//        ) ,
            let translated,
            !translated.isEmpty {
            let translation = Translation(
                id: UUID(),
                fromCode: from.id,
                fromText: text,
                toCode: to.id,
                toText: translated,
                isFavorite: false
            )
            try await historyRepository.addToHistory(translation)
            return translation
        }
        return nil
    }
    
    func saveLanguages(from: Language?, to: Language?) async {
        settingsRpository.save(from: from, to: to)
    }
    
    func savedLanguages() async  -> (from: Language?, to: Language?) {
        settingsRpository.restoreLanguages()
    }
}

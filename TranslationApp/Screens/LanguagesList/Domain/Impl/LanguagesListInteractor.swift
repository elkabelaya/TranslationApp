//
//  LanguagesListInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//


final class LanguagesListInteractor: LanguagesListInteractorProtocol {
    private let languageRepository: LanguagesRepositoryProtocol
    private let settingsRepository: SettingsRepositoryProtocol
    
    init(languageRepository: LanguagesRepositoryProtocol,
         settingsRepository: SettingsRepositoryProtocol) {
        self.languageRepository = languageRepository
        self.settingsRepository = settingsRepository
    }
    
    func getLanguages(filter: String) async throws -> [Language] {
        return languageRepository.getList().filter {
            filter.isEmpty ||
            $0.name.lowercased().contains(filter.lowercased())
        }
    }
    
    func saveLanguage(lng: Language, for: LanguageType) async {
        switch `for` {
        case .from:
            settingsRepository.save(from: lng)
        case .to:
            settingsRepository.save(to: lng)
        }
    }
    
    func swap() async {
        settingsRepository.swapLanguages()
    }
}

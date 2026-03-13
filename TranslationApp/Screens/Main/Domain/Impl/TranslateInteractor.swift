//
//  TranslateInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 06.03.2026.
//

final class TranslateInteractor: TranslateInteractorProtocol {
    let languagesRepository: LanguagesRepositoryProtocol
    let translationRepository: TranlationRepositoryProtocol
    let settingsRpository: SettingsRepositoryProtocol

    
    init(languagesRepository: LanguagesRepositoryProtocol,
         translationRepository: TranlationRepositoryProtocol,
         settingsRpository: SettingsRepositoryProtocol) {
        self.languagesRepository = languagesRepository
        self.translationRepository = translationRepository
        self.settingsRpository = settingsRpository
        
    }
    
    func getLanguages(filter: String) async throws -> [Language] {
        return languagesRepository.getList().filter{
            $0.name.lowercased().contains(filter.lowercased())
        }
    }
    
    func translate(text: String, from: Language, to: Language) async throws -> String {
        try await translationRepository.get(from: from.id, to: to.id, text: text)
    }
    
    func saveLanguages(from: Language?, to: Language?) async {
        settingsRpository.save(from: from, to: to)
    }
    
    func savedLanguages() async  -> (from: Language?, to: Language?) {
        settingsRpository.restoreLanguages()
    }
}

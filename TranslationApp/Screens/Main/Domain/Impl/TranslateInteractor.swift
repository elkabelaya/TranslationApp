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
    let remoteIconsRepository: ContryIconsRemoteRepositoryProtocol
    let localIconsRepository: ContryIconsLocalRepositoryProtocol

    
    init(languagesRepository: LanguagesRepositoryProtocol,
         translationRepository: TranlationRepositoryProtocol,
         settingsRpository: SettingsRepositoryProtocol,
         remoteIconsRepository: ContryIconsRemoteRepositoryProtocol,
         localIconsRepository: ContryIconsLocalRepositoryProtocol) {
        self.languagesRepository = languagesRepository
        self.translationRepository = translationRepository
        self.settingsRpository = settingsRpository
        self.remoteIconsRepository = remoteIconsRepository
        self.localIconsRepository = localIconsRepository
        
    }
    
    func getLanguages(filter: String) async throws -> [Language] {
        return languagesRepository.getList().filter{
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

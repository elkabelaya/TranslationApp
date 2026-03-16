//
//  MainShareInteractor.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

final class MainShareInteractor: MainShareInteractorProtocol{
    let copyRepository: CopyRepositoryProtocol
    
    init(copyRepository: any CopyRepositoryProtocol) {
        self.copyRepository = copyRepository
    }
    
    func copy(string: String) async {
        copyRepository.copy(string)
    }
    
    func share(string: String) async {
        
    }
}

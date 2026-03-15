//
//  NetworkContryIconsRemoteRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 14.03.2026.
//

import Foundation

actor  NetworkContryIconsRemoteRepository: ContryIconsRemoteRepositoryProtocol {
    let iconsNetwork: NetworkProtocol
    let mapper: LanguageCountryMapperProtocol
    
    init(iconsNetwork: NetworkProtocol,
         mapper: LanguageCountryMapperProtocol) {
        self.iconsNetwork = iconsNetwork
        self.mapper = mapper
    }
    
    func getImage(lng: LanguageCode) async throws -> Data {
        try await iconsNetwork.get(path: "flags/4x3/\(mapper.map(lng)).svg").execute()
    }
}

typealias CounryCodeDto = String

protocol LanguageCountryMapperProtocol: Sendable {
    func map(_ from: LanguageCode) -> CounryCodeDto
}

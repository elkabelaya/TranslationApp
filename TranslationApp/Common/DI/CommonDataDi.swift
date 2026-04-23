//
//  CommonDi.swift
//  TranslationApp
//
//  Created by elka belaya  on 18.03.2026.
//

import SwiftData
import Foundation
import AVFAudio
import UIKit

extension ServiceLocator {
    func diCommonData() throws {
        register(AVSpeechSynthesizer.self) { _ in
            AVSpeechSynthesizer()
        }
        register(Bundle.self, Bundle.main)
        register(UserDefaults.self, UserDefaults.standard)
        register(UIPasteboard.self, UIPasteboard.general)

        register(FileManager.self, FileManager.default)

        register(Locale.Type.self, Locale.self)
        register(Locale.self, Locale.current)

        register(URLSession.self, URLSession.shared)

        register(ModelContainer.self, try DatabaseManager.createCurrentModelContainer())
        
        register(ModelContext.self) { r in
            let container: ModelContainer = r.resolve()!
            return container.mainContext
        }

        register(CoderProtocol.self) { _ in
            JSONCoder(
                encoder: JSONEncoder(),
                decoder: JSONDecoder()
            )
        }

        register(NetworkProtocol.self) { r in
            URLSessionNetwork(baseUrl: "https://flagicons.lipis.dev/",
                              coder: r.resolve()!,
                              urlSession: r.resolve()!
            )
        }

        register(LanguageCountryMapperProtocol.self) { _ in
            LanguageCountryMapper()
        }

        register(LanguageMapperProtocol.self) { _ in
            LanguageMapper()
        }

        register(TranslationMapperProtocol.self) { _ in
            TranslationMapper()
        }
        
        register(LngMapperProtocol.self) { _ in
            LngMapper()
        }

        register(AudioPlayerCreatorProtocol.self) { r in
            DefaultAudioPlayerCreator()
        }
        
        register(CopyRepositoryProtocol.self) { r in
            PasteboardCopyRepository(
                pasteboard: r.resolve()!
            )
        }

        register(ContryIconsLocalRepositoryProtocol.self) { r in
            let files = Files(fileManager: r.resolve()!, directory: .icons)
            return FileContryIconsLocalRepository(files: files, ext: .svg)
        }

        register(ContryIconsRemoteRepositoryProtocol.self) { r in
            return NetworkContryIconsRemoteRepository(
                iconsNetwork: r.resolve()!,
                mapper: r.resolve()!
            )
        }

        register(FavoritesRepositoryProtocol.self) { r in
            return  SwiftDataFavoritesRepository(
                context: r.resolve()!,
                mapper: r.resolve()!
            )
        }

        register(HistoryRepositoryProtocol.self) { r in
            return  SwiftDataHistoryRepository(
                context: r.resolve()!,
                mapper: r.resolve()!
            )
        }

        register(SettingsRepositoryProtocol.self,
                 UserDefaultsSettingsRepository(
                    userDefaults: self.resolve()!,
                    mapper: self.resolve()!,
                    coder: self.resolve()!
                 )
        )
        

        register(LanguagesRepositoryProtocol.self) { r in
            return  LocaleLanguageRepository(
                localeProvider: SystemLocaleProvider()
            )
        }

        register(SpeechRecognizerEngineProtocol.self) { r in
            return  SFSpeechRecognizerEngine()
        }

        register(SpeachRecognizerRepositoryProtocol.self) { r in
            return SFSpeechRecognizerRepository()
        }

        register(SpeechSynthesizerRepositoryProtocol.self) { r in
            AVFoundationSpeechSynthesizerRepository()
        }

        register(SoundRepositoryProtocol.self) { r in
            BundleSoundRepository(
                bundle: r.resolve()!,
                audioPlayerCreator: r.resolve()!
            )
        }
        register(TranlationRepositoryProtocol.self) { r in
            TranslationSessionRepository(
                mapper: r.resolve()!
            )
        }
    }
}



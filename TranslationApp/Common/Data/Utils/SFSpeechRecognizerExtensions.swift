//
//  SFSpeechRecognizerExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 26.03.2026.
//

import Speech

extension SFSpeechRecognizer {
    static func requestAuthorization() async -> SFSpeechRecognizerAuthorizationStatus {
//        return await withCheckedContinuation {continuation in
//            Task { @MainActor in
//                requestAuthorization {  status in
//                    Task { @MainActor in
//                        continuation.resume(returning: status)
//                    }
//                }
//            }
//        }
//        
        let status = await withCheckedContinuation { continuation in
                    SFSpeechRecognizer.requestAuthorization { status in
                        continuation.resume(returning: status)
                    }
                }
        return status
    }
    
    @MainActor static func isAuthorized() async -> Bool {
        return await Self.requestAuthorization() == SFSpeechRecognizerAuthorizationStatus.authorized
    }
}

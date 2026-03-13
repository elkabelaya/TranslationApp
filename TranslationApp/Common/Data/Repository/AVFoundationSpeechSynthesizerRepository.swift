//
//  AVFoundationTextToSpeachRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 09.03.2026.
//

import AVFoundation

actor AVFoundationSpeechSynthesizerRepository: SpeechSynthesizerRepositoryProtocol {
    private let synthesizer = AVSpeechSynthesizer()
    private var delegate: Delegate?
    
    func speak(_ text: String, lng: LanguageCode) async {
        return await withCheckedContinuation { continuation in
            if synthesizer.isSpeaking {
                synthesizer.stopSpeaking(at: .immediate)
                delegate?.resume()
            }
            
            delegate = Delegate(completionContinuation: continuation)
            
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: lng)
            utterance.rate = 0.5
            utterance.pitchMultiplier = 0.8
            synthesizer.speak(utterance)
        }
    }
    
    private final class Delegate: NSObject, AVSpeechSynthesizerDelegate {
        private let completionContinuation: CheckedContinuation<Void, Never>?
        init(completionContinuation: CheckedContinuation<Void, Never>) {
            self.completionContinuation = completionContinuation
        }
        
        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
            //
        }
        func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
            resume()
        }
        
        nonisolated func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
            resume()
        }
        
        func resume() {
            completionContinuation?.resume(returning: ())
        }
    }
}

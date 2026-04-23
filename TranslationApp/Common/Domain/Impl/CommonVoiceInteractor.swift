//
//  VoiceInteractorProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 09.03.2026.
//
import Combine
final class CommonVoiceInteractor: VoiceInteractorProtocol {
    let recogniserRepository: SpeachRecognizerRepositoryProtocol
    let synthesizerRepository: SpeechSynthesizerRepositoryProtocol
    let soundRepository: SoundRepositoryProtocol
    
    init(
        recogniserRepository: SpeachRecognizerRepositoryProtocol,
        synthesizerRepository: SpeechSynthesizerRepositoryProtocol,
        soundRepository: SoundRepositoryProtocol
    ) {
        self.recogniserRepository = recogniserRepository
        self.synthesizerRepository = synthesizerRepository
        self.soundRepository = soundRepository
    }
    
    func speak(text: String, language: Language) async throws {
        await synthesizerRepository.speak(text, lng: language.id)
    }
    
    func listen(language: Language) -> AsyncThrowingStream<String, Error> {
        return recogniserRepository.startStreaming(lng: language.id)
    }
        
    func notify()  async  {
        soundRepository.playSpeechSound()
    }
}

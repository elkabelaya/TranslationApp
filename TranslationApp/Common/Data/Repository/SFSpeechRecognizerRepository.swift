//
//  SFSpeachRecognizerRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 05.03.2026.
//
import Combine
import Foundation
@preconcurrency import AVFoundation
@preconcurrency import Speech

class SFSpeechRecognizerRepository: SpeachRecognizerRepositoryProtocol {

    private var continuation: AsyncThrowingStream<String, Error>.Continuation?
    
    // MARK: Swft 6.2.4 crash overlap
    private var engine: SpeechRecognizerEngineProtocol = SFSpeechRecognizerEngine()//TODO di
    private var timer: Timer?

    func startStreaming(
        lng: LanguageCode
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            self.continuation = continuation
            engine.delegate = self
            engine.start(lng: lng)
        }
    }
    
    func stop() async throws {
        engine.stop()
        continuation?.finish()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {[weak self] timer in
            Task {
                try? await self?.stop()
            }
        }
    }
}

extension SFSpeechRecognizerRepository: SpeechRecDelegate {
    func didRecognizeText(_ text: String) {
        self.continuation?.yield(text)
        resetTimer()
    }
}

protocol SpeechRecDelegate: AnyObject {
    func didRecognizeText(_ text: String)
}

protocol SpeechRecognizerEngineProtocol {
    var delegate: SpeechRecDelegate? { get set }
    func start(lng: String)
    func stop()
}

final class SFSpeechRecognizerEngine: SpeechRecognizerEngineProtocol {
    weak var delegate: SpeechRecDelegate? = nil
    
    var speechRecognizer: SFSpeechRecognizer?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    func start(lng: String) {
        Task {
            if await isAuthorized() {
                self.startRecognition(lng: lng)
            } else {
                //TODO
            }
        }
    }
    
    func startRecognition(lng: String) {
        do {//TODO di
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(
                .playAndRecord,
                mode: .measurement,
                options: [
                    .defaultToSpeaker,
                    .allowBluetoothHFP
                ]
            )
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru"))
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            recognitionRequest?.requiresOnDeviceRecognition = true
            guard let recognitionRequest = recognitionRequest else { return }
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    self.delegate?.didRecognizeText(result.bestTranscription.formattedString)
                    
                }
            }
            
            let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
            audioEngine.inputNode.removeTap(onBus: 0)
            audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { @Sendable (buffer, _) in
                DispatchQueue.global(qos: .userInitiated).async {
                    recognitionRequest.append(buffer)
                }
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
        }
        
        catch {
            
        }
    }
    
    func stop() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
    
    private func isAuthorized() async -> Bool {
        //TODO extract to auth repo
        var status = SFSpeechRecognizer.authorizationStatus()
        
        if status == .notDetermined {
            status = await  withCheckedContinuation { continuation in
                SFSpeechRecognizer.requestAuthorization { status in
                    continuation.resume(returning: status)
                }
            }
        }
        
        if status == .authorized {
            return await AVAudioApplication.requestRecordPermission()
        }
        
        return false
    }
}


   


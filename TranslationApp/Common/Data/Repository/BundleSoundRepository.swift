//
//  BundleSoundRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 13.03.2026.
//

import Foundation
import AVFAudio

protocol AudioPlayerCreatorProtocol {
    func getAudioPlayer(contentsOf url: URL) throws -> AVAudioPlayer
}

final class DefaultAudioPlayerCreator: AudioPlayerCreatorProtocol {
    func getAudioPlayer(contentsOf url: URL) throws -> AVAudioPlayer {
        try AVAudioPlayer(contentsOf: url)
    }
}

final class BundleSoundRepository: NSObject, AVAudioPlayerDelegate, SoundRepositoryProtocol {
    private var bundle: Bundle
    private var audioPlayerCreator: AudioPlayerCreatorProtocol
    private var audioPlayer: AVAudioPlayer?
    
    init(bundle: Bundle, audioPlayerCreator: AudioPlayerCreatorProtocol) {
        self.bundle = bundle
        self.audioPlayerCreator = audioPlayerCreator
    }
    
    func playSpeechSound() {
        playSound(soundFileName: "beep-07a", fileExtension: "mp3")
    }
    
    private func playSound(soundFileName: String, fileExtension: String) {
        guard let url = bundle.url(forResource: soundFileName, withExtension: fileExtension) else {
            return
        }

        do {
            audioPlayer = try audioPlayerCreator.getAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()

        } catch {
            
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    }
}

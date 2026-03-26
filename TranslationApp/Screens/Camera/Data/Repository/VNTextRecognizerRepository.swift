//
//  VNTextRecognizerRepository.swift
//  TranslationApp
//
//  Created by elka belaya  on 25.03.2026.
//

import Combine
import CoreMedia
import Vision
import UIKit

final class VNTextRecognizerRepository: TextRecognizerRepositoryProtocol {
    
    private var language: String?
    private let mapper: VNObservationMapperProtocol
    var recognizedTexts: PassthroughSubject<[TextObservation], Never> = .init()
    
    init(mapper:  VNObservationMapperProtocol) {
        self.mapper = mapper
    }
    
    func setLanguage(_ language: LanguageCode) {
        self.language = language
    }
    
    func recognize(in data: Any) {
        var requestHandler: VNImageRequestHandler?
        switch data {
        case let image as UIImage:
            if let cgImage = image.cgImage {
                requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            }
        case let sampleBuffer as CMSampleBuffer:
        requestHandler = VNImageRequestHandler(
            cmSampleBuffer: sampleBuffer,
            orientation: .down//TODO
        )
        
        default:
            requestHandler = nil
        }
    
        guard let requestHandler else {
            self.recognizedTexts.send([])
            return
        }
        
        let request = VNRecognizeTextRequest(completionHandler: textDetectHandler)
        if let language {
            request.automaticallyDetectsLanguage = false
            request.recognitionLanguages = [language]
        } else {
            request.automaticallyDetectsLanguage = true
        }
        
        do {
            try requestHandler.perform([request])
        } catch {
            self.recognizedTexts.send([])
        }
    }

    func textDetectHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else { return }
        
        let obs = observations.map { mapper.map($0) }
        
        self.recognizedTexts.send(obs)
    }
}

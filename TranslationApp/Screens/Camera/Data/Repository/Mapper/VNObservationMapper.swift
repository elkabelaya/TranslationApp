//
//  VNObservationMapperProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import Vision

final class VNObservationMapper: VNObservationMapperProtocol {
    func map(_ from: VNRecognizedTextObservation) -> TextObservation {
        TextObservation(
            text: from.topCandidates(1).first?.string ?? "",
            boundingBox: from.boundingBox
        )
    }
}

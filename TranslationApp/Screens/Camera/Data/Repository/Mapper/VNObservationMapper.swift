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
            boundingBox: from.boundingBox,
            topLeading: from.topLeft,
            anglePi: atan2(from.topRight.y - from.topLeft.y, from.topRight.x - from.topLeft.x) * 180.0 / .pi
        )
    }

}

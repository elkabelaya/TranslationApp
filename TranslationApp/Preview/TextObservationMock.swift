//
//  TextObservationMock.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//
import CoreGraphics
extension TextObservation {
    static var mock: TextObservation {
        TextObservation(
            text: "test",
            boundingBox: CGRect(x: 0.2, y: 0.5, width: 0.4, height: 0.4)
        )
    }
    static var otherMock: TextObservation {
        TextObservation(
            text: "other",
            boundingBox: CGRect(x: 0.05, y: 0.2, width: 0.9, height: 0.2)
        )
    }
    static var mocks: [TextObservation] { [mock, otherMock] }
}

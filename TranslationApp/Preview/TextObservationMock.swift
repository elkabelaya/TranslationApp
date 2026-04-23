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
            boundingBox: CGRect(x: 0.2, y: 0.5, width: 0.4, height: 0.4),
            topLeading: CGPoint(x: 0.303262, y: 0.434215),
            anglePi: 0
//            frame: TextFrame(
//                topLeft: CGPoint(x: 0.303262, y: 0.434215),
//                topRight  : CGPoint(x: 0.665785, y: 0.603262),
//                bottomLeft: CGPoint(x: 0.134215, y: 0.796738),
//                bottomRight: CGPoint(x: 0.496738, y: 0.965785)
//            )
        )
    }
    static var otherMock: TextObservation {
        TextObservation(
            text: "other",
            boundingBox: CGRect(x: 0.05, y: 0.2, width: 0.9, height: 0.2),
            topLeading: CGPoint(x: 0.134399, y: 0.019089),
            anglePi: 25
//            frame: TextFrame(
//                topLeft: CGPoint(x: 0.134399, y: 0.019089),
//                topRight: CGPoint(x: 0.950125, y: 0.399649),
//                bottomLeft: CGPoint(x: 0.049875, y: 0.200351),
//                bottomRight: CGPoint(x: 0.865601, y: 0.580911)
//            )
        )
    }
    static var mocks: [TextObservation] { [mock, otherMock] }
}

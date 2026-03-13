//
//  CoderProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Foundation

protocol EncoderProtocol {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

protocol DecoderProtocol {
    func decode<T: Decodable>(_ type: T.Type, from: Data) throws -> T
}

protocol CoderProtocol: EncoderProtocol & DecoderProtocol{}

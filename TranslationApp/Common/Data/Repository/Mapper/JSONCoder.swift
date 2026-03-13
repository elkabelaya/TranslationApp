//
//  JSONCoder.swift
//  TranslationApp
//
//  Created by elka belaya  on 11.03.2026.
//

import Foundation

extension JSONEncoder: EncoderProtocol{}
extension JSONDecoder: DecoderProtocol{}

final class JSONCoder: CoderProtocol {
    var encoder: JSONEncoder
    var decoder: JSONDecoder
    
    init(encoder: JSONEncoder, decoder: JSONDecoder) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func encode<T>(_ value: T) throws -> Data where T : Encodable {
        try encoder.encode(value)
    }
    
    func decode<T>(_ type: T.Type, from: Data) throws -> T where T : Decodable {
        try decoder.decode(T.self, from: from)
    }
}

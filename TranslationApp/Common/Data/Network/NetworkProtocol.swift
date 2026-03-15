//
//  NetworkProtocol.swift
//  TranslationApp
//
//  Created by elka belaya  on 14.03.2026.
//
protocol AnyRequestProtocol: Sendable {
    func headers(_ headers: [String: String]) -> Self
    func params(_ params: [String: String]) -> Self
    func execute<T: Decodable>() async throws -> T
}

protocol BodyRequestProtocol: AnyRequestProtocol {
    func body<E: Encodable>(_ body: E) throws -> Self
}

protocol NetworkProtocol: Sendable {
    func get(path: String) async throws -> AnyRequestProtocol
    func post(path: String) async throws -> BodyRequestProtocol
}




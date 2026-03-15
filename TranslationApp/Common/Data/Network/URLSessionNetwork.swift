//  URLSessionNetwork.swift
//  TranslationApp
//
//  Created by elka belaya  on 14.03.2026.

import Foundation

nonisolated final class URLSessionNetwork: NetworkProtocol {
    private let baseUrl: String
    private let coder: CoderProtocol
    private let urlSession: URLSession
    
    init(baseUrl: String,
         coder: CoderProtocol,
         urlSession: URLSession) {
        self.baseUrl = baseUrl
        self.coder = coder
        self.urlSession = urlSession
    }

    func get(path: String) async throws -> AnyRequestProtocol {
        request(path: path, method: "GET")
    }
    
    func post(path: String) async throws -> BodyRequestProtocol {
        request(path: path, method: "POST")
    }
    
    private func request(path: String, method: String) -> BodyRequestProtocol {
        var request = URLRequest(url: createUrl(path: path))
        request.httpMethod = method
        return Request(urlRequest: request, urlSession: urlSession, coder: coder)
    }

    private func createUrl(path: String) -> URL {
        return URL(string: "\(baseUrl)\(path)")!
    }
}

struct Request: AnyRequestProtocol {
    let urlRequest: URLRequest
    let urlSession: URLSession
    let coder: CoderProtocol
    
    func execute<T: Decodable>() async throws -> T {
        let (data, response) = try await urlSession.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        if T.self == Data.self {
            return data as! T
        }
        
        return try coder.decode(T.self, from: data)
    }
    
    func headers(_ headers: [String : String]) -> Self {
        var request = urlRequest
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        return Request(urlRequest: request, urlSession: urlSession, coder: coder)
    }
    
    func params(_ params: [String : String]) -> Self {
        var request = urlRequest
        if let url = urlRequest.url,
           var urlComponents = URLComponents(string: url.absoluteString) {
            let queryItems: [URLQueryItem] = params.map { name, value in
                URLQueryItem(name: name, value: value)
            }
            
            urlComponents.queryItems = queryItems
            
            if let finalURL = urlComponents.url  {
                request.url = finalURL
                return Request(urlRequest: request, urlSession: urlSession, coder: coder)
            }
        }
        return self
    }
    
}

extension Request: BodyRequestProtocol {
    func body<E, R>(_ body: E) throws -> R where E : Encodable, R : AnyRequestProtocol {
        var request = urlRequest
        request.httpBody = try coder.encode(body)
        return Request(urlRequest: request, urlSession: urlSession, coder: coder) as! R
    }
}

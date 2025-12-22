//
//  NetworkService.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T
    func fetch<T: Decodable>(from urlString: String) async throws -> T // TODO: მოვაშოროთ თუ არ დაგვჭირდება 
}

final class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    
    private let session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        try validateResponse(httpResponse, data: data)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }

    func fetch<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidResponse
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        try validateResponse(httpResponse, data: data)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse, data: Data) throws {

        let errorMessage = (try? JSONDecoder().decode(ErrorResponse.self, from: data))?.error

        switch response.statusCode {

        case 200...299:
            return

        case 401:
            SessionManager.shared.logout()
            throw NetworkError.clientError(401, message: errorMessage)

        case 400...499:
            throw NetworkError.clientError(response.statusCode, message: errorMessage)

        case 500...599: throw NetworkError.serverError(response.statusCode, message: errorMessage)

        default:
            throw NetworkError.unknownError(response.statusCode)
        }
    }

}

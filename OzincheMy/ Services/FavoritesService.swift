//
//  FavoritesService.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 25.11.2025.
//

import Foundation

final class FavoritesService {

    static let shared = FavoritesService()
    private init() {}

    private var token: String {
        Storage.sharedInstance.accessToken
    }

    // MARK: - Add to Favorite
    func addToFavorite(movieId: Int) async throws {
        guard let url = URL(string: "http://apiozinshe.mobydev.kz/core/V1/favorite") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["movieId": movieId]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)

        if let http = response as? HTTPURLResponse {
            guard http.statusCode == 200 || http.statusCode == 201 else {
                throw URLError(.badServerResponse)
            }
        }
    }

    // MARK: - Remove from Favorite
    func removeFromFavorite(movieId: Int) async throws {
        guard let url = URL(string: "http://apiozinshe.mobydev.kz/core/V1/favorite/") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["movieId": movieId]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (_, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse,
              http.statusCode == 200 || http.statusCode == 201 else {
            throw URLError(.badServerResponse)
        }
    }

    // MARK: - Fetch Favorites List
    func fetchFavoriteMovies() async throws -> [Movie] {
        guard let url = URL(string: "http://apiozinshe.mobydev.kz/core/V1/favorite/") else { return [] }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Movie].self, from: data)
    }
}

//
//  UserService.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 29.11.2025.
//

import Foundation

final class UserService {
    static let shared = UserService()
    private init() {}

    private var token: String {
        Storage.sharedInstance.accessToken
    }

    // MARK: - Получить профиль
    
    func fetchProfile() async throws -> UserProfileResponse {
        guard let url = URL(string: URLs.GET_PROFILE_URL) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(http.statusCode) else {
            print("❌ Fetch failed:", http.statusCode)
            print("Body:", String(data: data, encoding: .utf8) ?? "")
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(UserProfileResponse.self, from: data)
    }

    // MARK: - Обновить профиль
    
    func updateProfile(_ dto: UpdateUserProfileRequest) async throws -> UserProfileResponse {
        guard let url = URL(string: URLs.UPDATE_PROFILE_URL) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(dto)

        // ⬇️⬇️⬇️ ЛОГИРУЕМ ТО, ЧТО УЛЕТАЕТ НА СЕРВЕР
        if let json = String(data: request.httpBody ?? Data(), encoding: .utf8) {
            print("➡️ UPDATE PROFILE — OUTGOING JSON:")
            print(json)
        }
        print("➡️ URL:", url.absoluteString)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // ЛОГИРУЕМ ОТВЕТ
        let body = String(data: data, encoding: .utf8) ?? ""
        print("⬅️ RESPONSE STATUS:", http.statusCode)
        print("⬅️ RESPONSE BODY:", body)

        guard (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(UserProfileResponse.self, from: data)
    }
    
    func changePassword(_ dto: ChangePasswordRequest) async throws {
            guard let url = URL(string: URLs.CHANGE_PASSWORD_URL) else {
                throw URLError(.badURL)
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = try JSONEncoder().encode(dto)

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }

            guard (200...299).contains(http.statusCode) else {

                let body = String(data: data, encoding: .utf8) ?? ""
                print("Change password resp status:", http.statusCode, "body:", body)

                throw URLError(.badServerResponse)
            }

            print("Password changed successfully!")
        }
}

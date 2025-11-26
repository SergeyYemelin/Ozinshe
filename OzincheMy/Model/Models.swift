//
//  Models.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 06.11.2025.
//

struct MainPageCategory: Decodable {
    let categoryId: Int
    let categoryName: String
    let movies: [Movie]
}

struct Movie: Decodable {
    let id: Int
    let movieType: String?
    let name: String
    let description: String
    let year: Int
    let director: String?
    let producer: String?
    let poster: Poster?
    let screenshots: [Poster]?
    let categoryAges: [Genre]?
    let genres: [Genre]?
    let categories: [Genre]?
    let video: Video?
    let seasonCount: Int?
    let seriesCount: Int?
    let watchCount: Int?
    var favorite: Bool
    let timing: Int?
}

struct Poster: Decodable {
    let id: Int
    let link: String?
    let fileId: Int?
    let movieId: Int?
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let link: String?
}

struct Video: Codable {
    let id: Int
    let link: String?
    let number: Int?
    let seasonId: Int?
}

struct Banner: Decodable {
    let id: Int
    let link: String
    let movie: Movie
}

struct Screenshot: Codable {
    let id: Int
    let link: String?
    let fileId: Int?
}

struct SimilarMovie {
    let imageName: String
    let title: String
    let subtitle: String
}

struct Category: Decodable {
    let id: Int
    let name: String
}






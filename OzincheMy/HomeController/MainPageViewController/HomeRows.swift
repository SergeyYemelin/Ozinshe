//
//  HomeRows.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 07.11.2025.
//

enum HomeRow {
    case bannerMovies([Banner])
    case movies(categoryName: String, movies: [Movie])
    case genres(items: [Genre], title: String)
}

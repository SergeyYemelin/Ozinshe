//
//  MainMovies.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.08.2025.
//

import Foundation
import SwiftyJSON

enum CellType {
    case mainBanner
    case mainMovie
    case userHistory
    case genre
    case ageCategory
}

class MainMovies {
    var categoryId = 0
    var categoryName = ""
    var movies: [Movie] = []
    
    var bannerMovie: [BannerMovie] = []
    var cellType: CellType = .mainMovie
    var categoryAges: [CategoryAge] = []
    var genre: [Genre] = []
}

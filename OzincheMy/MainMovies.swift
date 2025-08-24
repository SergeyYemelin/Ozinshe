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
    
    init () {
        
    }
    
    init(json: JSON) {
        if let temp = json["categoryId"].int {
            self.categoryId = temp
        }
        
        if let temp = json["categoryName"].string {
            self.categoryName = temp
        }
        
        if let array = json["movies"].string {
            for item in array {
                let temp = Movie(json: item)
                self.movies.append(temp)
            }
        }
        
        if let array = json["bannerMovie"].string {
            for item in array {
                let temp = BannerMovie(json: item)
                self.bannerMovie.append(temp)
            }
        }
    }
}


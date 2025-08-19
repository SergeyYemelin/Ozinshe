//
//  Urls.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 09.07.2025.
//

import Foundation

class Urls {
    static let BASE_URL = "https://api.ozinshe.com/core/V1/"
    
    static let SIGN_IN_URL = "https://api.ozinshe.com/auth/V1/signin"
    static let SIGN_UP_URL = "https://api.ozinshe.com/auth/V1/signup"
    static let FAVORITE_URL = BASE_URL + "favorite"
    static let CATEGORIES_URL = BASE_URL + "categories"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/search"
    static let MAIN_MOVIES_URL = BASE_URL + "movies/main"
    static let MAIN_BANNERS_URL = BASE_URL + "movies_main"
    static let USER_HISTORY_URL = BASE_URL + "history/userHistory"
    static let GET_GENRES = BASE_URL + "genres"
    static let GET_AGES = BASE_URL + "category-ages"
    static let GET_SIMILAR = BASE_URL + "movies/similar"
    static let GET_SEASONS = BASE_URL + "seasons/"
    static let GET_USER_PROFILE = BASE_URL + "user/profile"
    static let UPLOAD_USER_INFO = BASE_URL + "user/profile/"
    static let CHANGE_PASSWORD = BASE_URL + "user/profile/changePassword"
    
    
    
}

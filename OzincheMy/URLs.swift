//
//  Urls.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 09.07.2025.
//

struct URLs {
    static let BASE_AUTH_URL = "http://apiozinshe.mobydev.kz/auth/V1/"
    static let BASE_URL = "http://apiozinshe.mobydev.kz/core/V1/"
    
    static let SIGN_IN_URL = BASE_AUTH_URL + "signin"
    static let SIGN_UP_URL = BASE_AUTH_URL + "signup"
    
    static let MAIN_BANNERS_URL = BASE_URL + "movies_main"
    static let MOVIES_BY_CATEGORIES_URL = BASE_URL + "movies/main"
    static let GENRES_URL = BASE_URL + "genres"
    static let CATEGORY_AGES_URL = BASE_URL + "category-ages"
    static let MOVIE_BY_ID_URL = BASE_URL + "movies/"
    static let ALL_MOVIES_URL = BASE_URL + "movies"
    static let CATEGORIES_URL = BASE_URL + "categories"
    static let ADD_TO_FAVORITE = BASE_URL + "favorite"
    static let REMOVE_FROM_FAVORITE = BASE_URL + "favorite/"
    static let GET_FAVORITES = BASE_URL + "favorite/"
    static let GET_PROFILE_URL = BASE_URL + "user/profile"
    static let UPDATE_PROFILE_URL = BASE_URL + "user/profile/"
    static let CHANGE_PASSWORD_URL = BASE_URL + "user/profile/changePassword"
    static let HISTORY_MOVIES_URL = BASE_URL + "history/userHistory"
    static let ADD_TO_HISTORY_URL = BASE_URL + "history"
}

//
//  Constants.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 1.05.2022.
//

import Foundation

struct K {
    struct TheMovieDB {
        static let key = "697d439ac993538da4e3e60b54e762cd"
        static let url = "https://api.themoviedb.org"
        static let trendingMovie = url + "/3/trending/movie/day?api_key=" + key
        static let trendingTvs = url + "/3/trending/tv/day?api_key=" + key
        static let upcomingMovies = url + "/3/movie/upcoming?api_key=" + key + "&language=en-US&page=1"
        static let popular = url + "/3/movie/popular?api_key=" + key + "&language=en-US&page=1"
        static let topRated = url + "/3/movie/top_rated?api_key=" + key + "&language=en-US&page=1"
        static let discoverMovies = url + "/3/discover/movie?api_key=" + key + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        static let searchMovie = url + "/3/search/movie?api_key=" + key + "&query="// + query
    }
    
    struct Youtube {
        static let key = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
        static let url = "https://youtube.googleapis.com/youtube/v3/search?"
        static let search = url + "key=" + key + "&q=" // query
    }
}

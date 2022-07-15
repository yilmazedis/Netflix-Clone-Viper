//
//  Enums.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 1.05.2022.
//

import Foundation

enum ManagerError: Error {
    case noData
}

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

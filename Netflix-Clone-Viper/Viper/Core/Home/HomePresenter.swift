//
//  HomePresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import Foundation

protocol AnyHomePresenter {
    var router: AnyHomeRouter? { get set }
    var view: AnyHomeView? { get set }
    var interactor: AnyHomeInteractor? { get set }
    
    var headerView: HeroHeaderUIView? { get set }
    var randomTrendingMovie: Title? { get set }
    var sectionTitles: [String] { get }
    
    func getHeaderData(from address: String)
    func getSectionData(from address: String, make configure: @escaping (_ titles: [Title]) -> Void)
}

class HomePresenter: AnyHomePresenter {

    var headerView: HeroHeaderUIView?
    var randomTrendingMovie: Title?
    
    var router: AnyHomeRouter?
    var view: AnyHomeView?
    var interactor: AnyHomeInteractor?
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    
    func getHeaderData(from address: String) {
        interactor?.getData(from: address)
    }
    
    func getSectionData(from address: String, make configure: @escaping (_ titles: [Title]) -> Void) {
        interactor?.getSectionData(from: address, make: configure)
    }
}

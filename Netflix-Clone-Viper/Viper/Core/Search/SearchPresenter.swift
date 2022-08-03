//
//  SearchPresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnySearchPresenter {
    var view: AnySearchView? { set get }
    var interactor: AnySearchInteractor? { set get }
    var router: AnySearchRouter? { set get }
    
    var titles: [Title]? { set get }
    var title: Title? { set get }
    
    func fetchDiscoverMovies()
    func reloadTableView()
    func getYoutubeVideo(from address: String, with query: String)
    func titlePreviewConfigure(with videoElement: VideoElement)
    func updateSearchResults(from address: String, with query: String)
    func reloadCollectionView()
    func updateResultsController(with titles: [Title])
}

class SearchPresenter: AnySearchPresenter {
    var view: AnySearchView?
    var interactor: AnySearchInteractor?
    var router: AnySearchRouter?
    
    var title: Title?
    var titles: [Title]?
    
    func fetchDiscoverMovies() {
        interactor?.fetchDiscoverMovies()
    }
    
    func reloadTableView() {
        view?.reloadTableView()
    }
    
    func getYoutubeVideo(from address: String, with query: String) {
        interactor?.getYoutubeVideo(from: address, with: query)
    }
    
    func titlePreviewConfigure(with videoElement: VideoElement) {
        view?.titlePreviewConfigure(with: videoElement)
    }
    
    func updateSearchResults(from address: String, with query: String) {
        interactor?.updateSearchResults(from: address, with: query)
    }
    
    func reloadCollectionView() {
        view?.reloadCollectionView()
    }
    
    func updateResultsController(with titles: [Title]) {
        view?.updateResultsController(with: titles)
    }
}

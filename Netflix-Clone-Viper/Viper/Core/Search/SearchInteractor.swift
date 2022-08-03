//
//  SearchInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation
import UIKit

protocol AnySearchInteractor {
    var presenter: AnySearchPresenter? { set get }
    func fetchDiscoverMovies()
    func getYoutubeVideo(from address: String, with query: String)
    func updateSearchResults(from address: String, with query: String)
}

class SearchInteractor: AnySearchInteractor {
    var presenter: AnySearchPresenter?
    
    func fetchDiscoverMovies() {
        TheMovieDB.shared.get(from: K.TheMovieDB.discoverMovies) { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.titles = titles
                self?.presenter?.reloadTableView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getYoutubeVideo(from address: String, with query: String) {
        Youtube.shared.search(from: address, with: query) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.presenter?.titlePreviewConfigure(with: videoElement)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateSearchResults(from address: String, with query: String) {
        
        TheMovieDB.shared.search(from: address, with: query) { result in
            switch result {
            case .success(let titles):
                self.presenter?.updateResultsController(with: titles)
                self.presenter?.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

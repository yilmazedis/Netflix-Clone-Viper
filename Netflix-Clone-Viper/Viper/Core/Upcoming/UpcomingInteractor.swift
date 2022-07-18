//
//  UpcomingInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyUpcomingInteractor {
    var presenter: AnyUpcoimngPresenter? { set get }
    
    func getCellData(from address: String)
    func getYoutubeVideo(from address: String)
}

class UpcomingInteractor: AnyUpcomingInteractor {
    var presenter: AnyUpcoimngPresenter?
    
    func getCellData(from address: String) {
        TheMovieDB.shared.get(from: address) { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.titles = titles
                DispatchQueue.main.async {
                    self?.presenter?.uploadTableView()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getYoutubeVideo(from address: String) {
        TheMovieDB.shared.getMovie(with: address) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    self?.presenter?.navigateToTitlePreviewView(with: videoElement)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

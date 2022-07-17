//
//  HomeInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import Foundation

protocol AnyHomeInteractor {
    var presenter: AnyHomePresenter? { get set }
    func getData(from address: String)
    func getSectionData(from address: String, make configure: @escaping (_ titles: [Title]) -> Void)
}

class HomeInteractor: AnyHomeInteractor {
    var presenter: AnyHomePresenter?
    
    func getData(from address: String) {
        TheMovieDB.shared.get(from: address) { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()

                self?.presenter?.randomTrendingMovie = selectedTitle
                self?.presenter?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))

            case .failure(let erorr):
                print(erorr.localizedDescription)
            }
        }
    }
    
    func getSectionData(from address: String, make configure: @escaping (_ titles: [Title]) -> Void) {
        TheMovieDB.shared.get(from: address) { result in
            switch result {
            case .success(let titles):
                configure(titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//
//  HomeInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import Foundation

protocol AnyHomeInteractor {
    var presenter: AnyHomePresenter? { get set }
}

class HomeInteractor: AnyHomeInteractor {
    var presenter: AnyHomePresenter?
}

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
}

class HomePresenter: AnyHomePresenter {
    var router: AnyHomeRouter?
    var view: AnyHomeView?
    var interactor: AnyHomeInteractor?
    
}

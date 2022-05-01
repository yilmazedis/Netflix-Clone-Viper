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
}

class SearchPresenter: AnySearchPresenter {
    var view: AnySearchView?
    var interactor: AnySearchInteractor?
    var router: AnySearchRouter?
}

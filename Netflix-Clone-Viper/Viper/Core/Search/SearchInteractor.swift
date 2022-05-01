//
//  SearchInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnySearchInteractor {
    var presenter: AnySearchPresenter? { set get }
}

class SearchInteractor: AnySearchInteractor {
    var presenter: AnySearchPresenter?
}

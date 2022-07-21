//
//  SearchResultsPresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnySearchResultsPresenter {
    var view: AnySearchResultsView? { set get }
    var interactor: AnySearchResultsInteractor? { set get }
    var router: AnySearchResultsRouter? { set get }
}

class SearchResultsPresnter: AnySearchResultsPresenter {
    var view: AnySearchResultsView?
    var interactor: AnySearchResultsInteractor?
    var router: AnySearchResultsRouter?
    
    
}

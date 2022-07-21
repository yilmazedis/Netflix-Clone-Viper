//
//  SearchResultsInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnySearchResultsInteractor {
    var presenter: AnySearchResultsPresenter? { set get }
}

class SearchResultsInteractor: AnySearchResultsInteractor {
    var presenter: AnySearchResultsPresenter?
    
    
}

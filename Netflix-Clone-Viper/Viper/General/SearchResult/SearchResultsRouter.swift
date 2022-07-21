//
//  SearchResultsRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnySearchResultsRouter {
    var entry: SearchResultsEntryPoint? { get }
    
    static func start() -> AnySearchResultsRouter
}

class SearchResultsRouter: AnySearchResultsRouter {
    var entry: SearchResultsEntryPoint?
    
    static func start() -> AnySearchResultsRouter {
        
        let router = SearchResultsRouter()
        
        let view = SearchResultsView()
        let presenter = SearchResultsPresnter()
        let interactor = SearchResultsInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as SearchResultsEntryPoint
        
        return router
    }
    
}

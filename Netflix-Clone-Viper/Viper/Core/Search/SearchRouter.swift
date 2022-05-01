//
//  SearchRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnySearchRouter {
    var entry: SearchEntryPoint? { get }
    
    static func start() -> AnySearchRouter
}

class SearchRouter: AnySearchRouter {
    
    var entry: SearchEntryPoint?
    
    static func start() -> AnySearchRouter {
        
        let router = SearchRouter()
        
        let view = SearchView()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as SearchEntryPoint
        
        return router
    }
    
}

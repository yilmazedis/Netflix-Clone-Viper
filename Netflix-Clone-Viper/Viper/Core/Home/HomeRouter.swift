//
//  HomeRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import Foundation

protocol AnyHomeRouter {
    var entry: HomeEntryPoint? { get }
    
    static func start() -> AnyHomeRouter
}

class HomeRouter: AnyHomeRouter {
    var entry: HomeEntryPoint?
    
    static func start() -> AnyHomeRouter {
        let router = HomeRouter()
        
        let view = HomeView()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as HomeEntryPoint
        
        return router
    }
}

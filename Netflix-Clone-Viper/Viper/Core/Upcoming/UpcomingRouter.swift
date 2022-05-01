//
//  UpcomingRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyUpcomingRouter {
    var entry: UpcomingEntryPoint? { get }
    
    static func start() -> AnyUpcomingRouter
}

class UpcomingRouter: AnyUpcomingRouter {
    var entry: UpcomingEntryPoint?
    
    static func start() -> AnyUpcomingRouter {
        
        let router = UpcomingRouter()
        
        let view = UpcomingView()
        let presenter = UpcomingPresenter()
        let interactor = UpcomingInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as UpcomingEntryPoint
        
        return router
    }
    
    
}

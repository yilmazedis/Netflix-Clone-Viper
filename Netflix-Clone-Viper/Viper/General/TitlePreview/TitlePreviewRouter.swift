//
//  TitlePreviewRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnyTitlePreviewRouter {
    var entry: TitlePreviewEntryPoint? { get }
    
    static func start() -> AnyTitlePreviewRouter
}

class TitlePreviewRouter: AnyTitlePreviewRouter {
    var entry: TitlePreviewEntryPoint?
    
    static func start() -> AnyTitlePreviewRouter {
        
        let router = TitlePreviewRouter()
        
        let view = TitlePreviewView()
        let presenter = TitlePreviewPresenter()
        let interactor = TitlePreviewInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as TitlePreviewEntryPoint
        
        return router
    }
    
    
}

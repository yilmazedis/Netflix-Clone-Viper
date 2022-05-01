//
//  DownloadsRouter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation


protocol AnyDownloadRouter {
    var entry: DownloadEntryPoint? { get }
    
    static func start() -> AnyDownloadRouter
}

class DownloadRouter: AnyDownloadRouter {
    var entry: DownloadEntryPoint?
    
    static func start() -> AnyDownloadRouter {
        
        let router = DownloadRouter()
        
        let view = DownloadView()
        let presenter = DownloadPresnter()
        let interactor = DownloadInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        router.entry = view as DownloadEntryPoint
        
        return router
    }
    
}

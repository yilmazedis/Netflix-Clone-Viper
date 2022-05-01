//
//  DownloadsPresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyDownloadPresenter {
    var view: AnyDownloadView? { set get }
    var interactor: AnyDownloadInteractor? { set get }
    var router: AnyDownloadRouter? { set get }
}

class DownloadPresnter: AnyDownloadPresenter {
    var view: AnyDownloadView?
    var interactor: AnyDownloadInteractor?
    var router: AnyDownloadRouter?
    
    
}

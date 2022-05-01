//
//  UpcomingPresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyUpcoimngPresenter {
    var view: AnyUpcomingView? { set get }
    var interactor: AnyUpcomingInteractor? { set get }
    var router: AnyUpcomingRouter? { set get }
}

class UpcomingPresenter: AnyUpcoimngPresenter {
    var view: AnyUpcomingView?
    var interactor: AnyUpcomingInteractor?
    var router: AnyUpcomingRouter?
    
}

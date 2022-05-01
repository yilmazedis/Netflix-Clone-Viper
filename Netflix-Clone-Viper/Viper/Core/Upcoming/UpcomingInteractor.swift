//
//  UpcomingInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyUpcomingInteractor {
    var presenter: AnyUpcoimngPresenter? { set get }
}

class UpcomingInteractor: AnyUpcomingInteractor {
    var presenter: AnyUpcoimngPresenter?
}

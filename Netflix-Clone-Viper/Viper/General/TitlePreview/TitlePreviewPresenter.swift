//
//  TitlePreviewPresenter.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnyTitlePreviewPresenter {
    var view: AnyTitlePreviewView? { set get }
    var interactor: AnyTitlePreviewInteractor? { set get }
    var router: AnyTitlePreviewRouter? { set get }
}

class TitlePreviewPresenter: AnyTitlePreviewPresenter {
    var view: AnyTitlePreviewView?
    var interactor: AnyTitlePreviewInteractor?
    var router: AnyTitlePreviewRouter?
    
}

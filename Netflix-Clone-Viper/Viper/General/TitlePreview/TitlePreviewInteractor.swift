//
//  TitlePreviewInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation

protocol AnyTitlePreviewInteractor {
    var presenter: AnyTitlePreviewPresenter? { set get }
}

class TitlePreviewInteractor: AnyTitlePreviewInteractor {
    var presenter: AnyTitlePreviewPresenter?
}

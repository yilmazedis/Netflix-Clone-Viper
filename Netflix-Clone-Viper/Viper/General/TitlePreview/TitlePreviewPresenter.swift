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
    
    func configure(with model: TitlePreviewViewModel)
}

class TitlePreviewPresenter: AnyTitlePreviewPresenter {
    var view: AnyTitlePreviewView?
    var interactor: AnyTitlePreviewInteractor?
    var router: AnyTitlePreviewRouter?
 
    func configure(with model: TitlePreviewViewModel) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        view?.webViewLoad(with: url)
    }
}

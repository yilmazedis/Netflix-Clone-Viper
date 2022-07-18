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
    
    var titles: [Title]? { get set }
    var title: Title? { get set }
    func getCellData(from address: String)
    func getYoutubeVideo(with index: Int)
    func uploadTableView()
    func navigateToTitlePreviewView(with model: VideoElement)
}

class UpcomingPresenter: AnyUpcoimngPresenter {
    var view: AnyUpcomingView?
    var interactor: AnyUpcomingInteractor?
    var router: AnyUpcomingRouter?
    
    var title: Title?
    var titles: [Title]?
    
    func getCellData(from address: String) {
        interactor?.getCellData(from: address)
    }
    
    func getYoutubeVideo(with index: Int) {
        
        guard let title = titles?[index] else {
            return
        }

        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        self.title = title
        interactor?.getYoutubeVideo(from: titleName)
    }
    
    func uploadTableView() {
        view?.uploadTableView()
    }
    
    func navigateToTitlePreviewView(with model: VideoElement) {
        view?.navigateToTitlePreviewView(with: model)
    }
}

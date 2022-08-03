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
    
    var title: TitleItem? { set get }
    var titles: [TitleItem]? { set get }
    
    func titlePreviewConfigure(with videoElement: VideoElement)
    func getYoutubeVideo(from address: String, with query: String)
    func fetchLocalStorageForDownload()
    func reloadTableView()
    func deleteRow(index: IndexPath)
    func deleteTitleWith(index: IndexPath)
}

class DownloadPresnter: AnyDownloadPresenter {
    var view: AnyDownloadView?
    var interactor: AnyDownloadInteractor?
    var router: AnyDownloadRouter?
    
    var title: TitleItem?
    var titles: [TitleItem]?
        
    func titlePreviewConfigure(with videoElement: VideoElement) {
        view?.titlePreviewConfigure(with: videoElement)
    }
    
    func getYoutubeVideo(from address: String, with query: String)  {
        interactor?.getYoutubeVideo(from: address, with: query)
    }
    
    func reloadTableView() {
        view?.reloadTableView()
    }
    
    func fetchLocalStorageForDownload() {
        interactor?.fetchLocalStorageForDownload()
    }
    
    func deleteRow(index: IndexPath) {
        view?.deleteRow(index: index)
    }
    
    func deleteTitleWith(index: IndexPath) {
        interactor?.deleteTitleWith(index: index)
    }
}

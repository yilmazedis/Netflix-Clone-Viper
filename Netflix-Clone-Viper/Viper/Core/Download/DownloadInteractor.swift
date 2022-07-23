//
//  DownloadsInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter? { set get }
    
    func getYoutubeVideo(from address: String, with query: String)
}

class DownloadInteractor: AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter?
    
    func getYoutubeVideo(from address: String, with query: String) {
        Youtube.shared.search(from: address, with: query) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.presenter?.titlePreviewConfigure(with: videoElement)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

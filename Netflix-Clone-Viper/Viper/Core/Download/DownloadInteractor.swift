//
//  DownloadsInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter? { set get }
}

class DownloadInteractor: AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter?
    
    
}

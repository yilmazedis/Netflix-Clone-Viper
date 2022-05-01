//
//  DownloadsView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyDownloadView {
    var presenter: AnyDownloadPresenter? { get set }
}

class Downloads

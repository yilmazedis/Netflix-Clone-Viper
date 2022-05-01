//
//  DownloadsView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation
import UIKit

typealias DownloadEntryPoint = AnyDownloadView & UIViewController

protocol AnyDownloadView {
    var presenter: AnyDownloadPresenter? { set get }
}

class DownloadView: UIViewController, AnyDownloadView {
    var presenter: AnyDownloadPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
    }
}

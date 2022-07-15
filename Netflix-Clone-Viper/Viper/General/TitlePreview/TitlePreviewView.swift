//
//  TitlePreviewView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 5.05.2022.
//

import Foundation
import UIKit

typealias TitlePreviewEntryPoint = AnyTitlePreviewView & UIViewController

protocol AnyTitlePreviewView {
    var presenter: AnyTitlePreviewPresenter? { set get }
}

class TitlePreviewView: UIViewController, AnyTitlePreviewView {
    var presenter: AnyTitlePreviewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
    }
}

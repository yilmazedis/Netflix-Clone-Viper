//
//  SearchView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation
import UIKit


typealias SearchEntryPoint = AnySearchView & UIViewController

protocol AnySearchView {
    var presenter: AnySearchPresenter? { set get }
}

class SearchView: UIViewController, AnySearchView {
    var presenter: AnySearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }
}

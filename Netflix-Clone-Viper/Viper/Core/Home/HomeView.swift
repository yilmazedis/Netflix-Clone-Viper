//
//  HomeView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import Foundation
import UIKit

typealias HomeEntryPoint = AnyHomeView & UIViewController

protocol AnyHomeView {
    var presenter: AnyHomePresenter? { get set }
}

class HomeView: UIViewController, AnyHomeView {
    var presenter: AnyHomePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBrown
    }
    
}

//
//  UpcomingView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation
import UIKit

typealias UpcomingEntryPoint = AnyUpcomingView & UIViewController

protocol AnyUpcomingView {
    var presenter: AnyUpcoimngPresenter? { set get }
}

class UpcomingView: UIViewController, AnyUpcomingView {
    var presenter: AnyUpcoimngPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
    }
}

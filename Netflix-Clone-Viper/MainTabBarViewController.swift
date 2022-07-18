//
//  ViewController.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 28.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let home = UINavigationController(rootViewController: HomeRouter.start().entry!)
        let upcoming = UINavigationController(rootViewController: UpcomingRouter.start().entry!)
        let search = UINavigationController(rootViewController: SearchRouter.start().entry!)
        let download = UINavigationController(rootViewController: DownloadRouter.start().entry!)
        
        home.tabBarItem.image = UIImage(systemName: "house")
        upcoming.tabBarItem.image = UIImage(systemName: "play.circle")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        download.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        home.title = "Home"
        upcoming.title = "Upcoming"
        search.title = "Search"
        download.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([home, upcoming, search, download], animated: true)
    }
}

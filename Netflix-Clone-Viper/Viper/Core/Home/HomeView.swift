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

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self

        configureNavbar()

        presenter?.headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = presenter?.headerView
        configureHeroHeaderView()
    }

    private func configureHeroHeaderView() {
        presenter?.getHeaderData(from: K.TheMovieDB.trendingMovie)
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sectionTitles.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }

        cell.delegate = self

        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            presenter?.getSectionData(from: K.TheMovieDB.trendingMovie, make: cell.configure)
        case Sections.TrendingTv.rawValue:
            presenter?.getSectionData(from: K.TheMovieDB.trendingTvs, make: cell.configure)
        case Sections.Popular.rawValue:
            presenter?.getSectionData(from: K.TheMovieDB.popular, make: cell.configure)
        case Sections.Upcoming.rawValue:
            presenter?.getSectionData(from: K.TheMovieDB.upcomingMovies, make: cell.configure)
        case Sections.TopRated.rawValue:
            presenter?.getSectionData(from: K.TheMovieDB.topRated, make: cell.configure)
        default:
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.sectionTitles[section]
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeView: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let vc = TitlePreviewRouter.start().entry as? TitlePreviewView else { return }
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

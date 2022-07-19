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
    func uploadTableView()
    func navigateToTitlePreviewView(with model: VideoElement)
}

class UpcomingView: UIViewController, AnyUpcomingView {
    var presenter: AnyUpcoimngPresenter?
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self

        fetchUpcoming()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }

    private func fetchUpcoming() {
        presenter?.getCellData(from: K.TheMovieDB.upcomingMovies)
    }
    
    func uploadTableView() {
        upcomingTable.reloadData()
    }
    
    func navigateToTitlePreviewView(with model: VideoElement) {
        
        guard let vc = TitlePreviewRouter.start().entry as? TitlePreviewView else { return }
        guard let title = presenter?.title else { return }
        
        vc.configure(with: TitlePreviewViewModel(title: title.original_title ?? "", youtubeView: model, titleOverview: title.overview ?? ""))

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UpcomingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.titles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }

        guard let title = presenter?.titles?[indexPath.row] else { return UITableViewCell() }
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unknown title name", posterURL: title.poster_path ?? ""))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.getYoutubeVideo(with: indexPath.row)
    }
}

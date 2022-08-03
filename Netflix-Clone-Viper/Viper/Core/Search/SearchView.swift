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
    
    func reloadTableView()
    func titlePreviewConfigure(with videoElement: VideoElement)
    func reloadCollectionView()
    func updateResultsController(with titles: [Title])
}

class SearchView: UIViewController, AnySearchView {
    var presenter: AnySearchPresenter?
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsView())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private var resultsController: SearchResultsView = {
        let view = SearchResultsView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = .white
        presenter?.fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    func titlePreviewConfigure(with videoElement: VideoElement) {
        DispatchQueue.main.async {
            guard let presenter = self.presenter else { return }
            guard let vc = TitlePreviewRouter.start().entry as? TitlePreviewView else { return }
            vc.configure(with: TitlePreviewViewModel(title: presenter.title?.original_title ?? "", youtubeView: videoElement, titleOverview: presenter.title?.overview ?? ""))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.discoverTable.reloadData()
        }
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.resultsController.searchResultsCollectionView.reloadData()
        }
    }
    
    func updateResultsController(with titles: [Title]) {
        resultsController.titles = titles
    }
}

extension SearchView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        guard let title = presenter?.titles?[indexPath.row] else { return UITableViewCell() }
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown name", posterURL: title.poster_path ?? "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let titleItem = presenter?.titles?[indexPath.row] else { return }
        presenter?.title = titleItem
        presenter?.getYoutubeVideo(from: K.Youtube.search,
                                   with: titleItem.original_name ?? titleItem.original_title ?? "")
    }
}

extension SearchView: UISearchResultsUpdating, SearchResultsViewDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 else {
            return
        }
        
        resultsController = searchController.searchResultsController as? SearchResultsView ?? SearchResultsView()
        resultsController.delegate = self
        
        presenter?.updateSearchResults(from: K.TheMovieDB.searchMovie, with: query)
    }
    
    func searchResultsViewDidTapItem(_ viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let vc = TitlePreviewRouter.start().entry as? TitlePreviewView else { return }
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

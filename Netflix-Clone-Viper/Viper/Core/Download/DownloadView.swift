//
//  DownloadsView.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import UIKit

typealias DownloadEntryPoint = AnyDownloadView & UIViewController

protocol AnyDownloadView {
    var presenter: AnyDownloadPresenter? { set get }
    
    func titlePreviewConfigure(with videoElement: VideoElement)
    func reloadTableView()
    func deleteRow(index: IndexPath)
}

class DownloadView: UIViewController, AnyDownloadView {
    var presenter: AnyDownloadPresenter?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(tableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            self?.presenter?.fetchLocalStorageForDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func titlePreviewConfigure(with videoElement: VideoElement) {
        DispatchQueue.main.async {
            guard let presenter = self.presenter else { return }
            guard let vc = TitlePreviewRouter.start().entry as? TitlePreviewView else { return }
            vc.configure(with: TitlePreviewViewModel(title: presenter.title?.original_name ?? "",
                                                     youtubeView: videoElement,
                                                     titleOverview: presenter.title?.overview ?? ""))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func deleteRow(index: IndexPath) {
        tableView.deleteRows(at: [index], with: .fade)
    }
}

extension DownloadView: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            presenter?.deleteTitleWith(index: indexPath)
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let titleItem = presenter?.titles?[indexPath.row] else { return }
        presenter?.title = titleItem
        presenter?.getYoutubeVideo(from: K.Youtube.search,
                                   with: titleItem.original_name ?? titleItem.original_title ?? "")
    }
}

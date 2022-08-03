//
//  DownloadsInteractor.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 30.04.2022.
//

import Foundation

protocol AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter? { set get }
    
    func getYoutubeVideo(from address: String, with query: String)
    func fetchLocalStorageForDownload()
    func deleteTitleWith(index: IndexPath)
}

class DownloadInteractor: AnyDownloadInteractor {
    var presenter: AnyDownloadPresenter?
    
    func getYoutubeVideo(from address: String, with query: String) {
        Youtube.shared.search(from: address, with: query) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.presenter?.titlePreviewConfigure(with: videoElement)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.titles = titles
                self?.presenter?.reloadTableView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteTitleWith(index: IndexPath) {
        
        guard let model = presenter?.titles?[index.row] else { return }
        
        DataPersistenceManager.shared.deleteTitleWith(model: model) { [weak self] result in
            switch result {
            case .success():
                print("Deleted fromt the database")
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.presenter?.titles?.remove(at: index.row)
            self?.presenter?.deleteRow(index: index)
        }
    }
}

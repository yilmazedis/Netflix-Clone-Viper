//
//  Youtube.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 1.05.2022.
//

import Foundation

class Youtube {
    
    static let shared = Youtube()
    
    func search(from address: String, with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        guard let url = URL(string: address + query) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
            } catch {
                completion(.failure(ManagerError.noData))
            }
        }
        
        task.resume()
    }
}

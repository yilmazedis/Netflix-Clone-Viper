//
//  TheMovieDB.swift
//  Netflix-Clone-Viper
//
//  Created by yilmaz on 1.05.2022.
//

import Foundation

class TheMovieDB {
    static let shared = TheMovieDB()
    
    func get(from address: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: address) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url) ) { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ManagerError.noData))
            }
        }
        
        task.resume()
    }
    
    func search(from address: String, with query: String, completion: @escaping (Result<[Title],Error>) -> Void) {
        
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
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ManagerError.noData))
            }

        }
        
        task.resume()
    }
}

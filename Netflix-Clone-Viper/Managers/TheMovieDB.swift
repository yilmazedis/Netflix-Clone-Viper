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
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(K.Youtube.url)q=\(query)&key=\(K.Youtube.key)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}



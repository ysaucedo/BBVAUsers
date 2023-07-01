//
//  RandomUsersService.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 29/06/23.
//

import Foundation

final class RandomUsersService {
    var currentPage: Int = 1
    
    func getRandomUsers(results: Int, completion: @escaping RequestCompletion<Results>) {
        
        guard let url = URL(string: "\(Constant.apiURL)?results=\(results)&seed=\(Constant.seed)&page=\(currentPage)") else { return }
        print(url)
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            do {
                
                guard (error == nil) else {
                    completion(.failure(error: error! as NSError))
                    return
                }

                guard let json = data, !json.isEmpty else { return }
                
                let decoder = JSONDecoder()
                let results:Results = try decoder.decode(Results.self, from: json)
                self?.currentPage = results.info.page
                
                completion(.success(response: results))
                
            } catch let error {
                completion(.failure(error: error as NSError))
            }
        }
        task.resume()
        
    }
    
    func nextPage() {
        currentPage += 1
    }
    
    func isFirstPage() -> Bool {
        currentPage == 1
    }
    
    
}

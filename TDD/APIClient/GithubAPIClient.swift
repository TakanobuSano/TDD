//
//  APIClient.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/01.
//  https://developer.apple.com/videos/play/wwdc2021/10132/

import Foundation

protocol GithubAPIClientProtocol {
    func fetchRepositories(user: String, completion: @escaping ([GitHubRepository]?, Error?) -> Void)
    func fetchRepositories(user: String) async throws -> [GitHubRepository]?
}

enum FetcherError: Error {
    case badURL
    case badCode
    case missingData
}

class GithubAPIClient: GithubAPIClientProtocol {
   
    /// クロージャ
    func fetchRepositories(user: String, completion: @escaping ([GitHubRepository]?, Error?) -> Void) {
        
        if let url = URL(string: "https://api.github.com/users/\(user)/repos") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(nil, error)
                }else if (response as? HTTPURLResponse)?.statusCode != 200{
                    completion(nil, FetcherError.badCode)
                }else {
                    guard let data = data else{
                        completion(nil, FetcherError.missingData)
                        return
                    }
                    let repos = try! JSONDecoder().decode([GitHubRepository].self, from: data)
                    DispatchQueue.main.async {
                        completion(repos, nil)
                    }
                }
            }
            task.resume()
        }else {
            completion(nil, FetcherError.badURL)
        }
    }

    /// Swift Concurrencyのasync/await
    func fetchRepositories(user: String) async throws -> [GitHubRepository]? {
        
        if let url = URL(string: "https://api.github.com/users/\(user)/repos") {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetcherError.badCode }
            let repos = try JSONDecoder().decode([GitHubRepository].self, from: data)
            return repos
        }else {
            throw FetcherError.badURL
        }
    }

}

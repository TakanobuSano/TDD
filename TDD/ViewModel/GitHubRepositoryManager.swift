//
//  GitHubRepositoryManager.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/01.
//

import Foundation
import SwiftUI


final class GitHubRepositoryManager: ObservableObject {
    
    @Published var majorRepositories: [GitHubRepository]?
    @Published var userName: String

    private let client: GithubAPIClientProtocol
    private var repos: [GitHubRepository]?
    
    var majorRepos: [GitHubRepository] {
        guard let repositories = self.repos else { return [] }
        return repositories.filter { repository in
            repository.stargazers_count >= 50
        }
    }
    
    func fetchMajorRepositories() {
        majorRepositories = majorRepos
    }

    init(client: GithubAPIClientProtocol = GithubAPIClient()) {
        self.client = client
        self.userName = ""
    }
    
    func load(user: String, completion: @escaping(Error?) -> Void) {
        self.userName = user
        self.client.fetchRepositories(user: self.userName) { repositories, error in
            if let error = error {
                completion(error)
            }
            self.repos = repositories
            completion(nil)
        }
    }
    
    func load(user: String) async throws {
        self.userName = user
        do {
            self.repos = try await self.client.fetchRepositories(user: self.userName)
        }catch {
            self.repos = []
            throw error
        }
    }
}

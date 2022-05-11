//
//  GitHubRepository.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/01.
//

import Foundation

protocol GitHubRepositoryProtocol {
    var id: Int { get set }
    var stargazers_count: Int { get set }
    var name: String { get set }
}

struct GitHubRepository: Codable, Equatable, GitHubRepositoryProtocol {
    
    var id: Int
    var stargazers_count: Int
    var name: String
    
//    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
//        return true
//    }
}

//
//  GitHubRepository.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/01.
//

import Foundation

struct GitHubRepository: Codable, Equatable {
    
    let id: Int
    let stargazers_count: Int
    let name: String
    
//    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
//        return true
//    }
}

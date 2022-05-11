//
//  GitHubrepositoryViewModelTest.swift
//  TDDTests
//
//  Created by 佐野貴信 on 2022/05/01.
//

import XCTest
@testable import TDD

class GitHubrepositoryViewModelTest: XCTestCase {
    
    class MockGithubAPIClient: GithubAPIClientProtocol {
        
        var mockRepositories: [GitHubRepository]
        
        init(repositories:[GitHubRepository]) {
            mockRepositories = repositories
        }
       
        func fetchRepositories(user: String, completion: @escaping ([GitHubRepository]?, Error?) -> Void) {
            completion(mockRepositories, nil)
        }
        
        func fetchRepositories(user: String) async throws -> [GitHubRepository]? {
            return mockRepositories
        }

    }

    var repositoryViewModel: GitHubRepositoryViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        /// モック
        let mockRepositories: [GitHubRepository] = [
            GitHubRepository(id: 0, stargazers_count: 48, name: "aaa"),
            GitHubRepository(id: 1, stargazers_count: 49, name: "bbb"),
            GitHubRepository(id: 2, stargazers_count: 50, name: "ccc"),
            GitHubRepository(id: 3, stargazers_count: 51, name: "ddd"),
            GitHubRepository(id: 4, stargazers_count: 52, name: "eee"),
        ]
        
        let mockAPIClient = MockGithubAPIClient(repositories: mockRepositories)
        self.repositoryViewModel = GitHubRepositoryViewModel(client: mockAPIClient)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// クロージャ
    func testFetchMajorRepositories_Closure() {
        
        self.repositoryViewModel?.load(user: "apple") {_ in
            self.repositoryViewModel?.fetchMajorRepositories()
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?.count, 3, "stargazers_countが５０以上が３つ存在する")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[0].name, "ccc", "stargazers_countが５０")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[1].name, "ddd", "stargazers_countが５１")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[2].name, "eee", "stargazers_countが５２")
        }
    }

    /// Swift Concurrencyのasync/await
    func testFetchMajorRepositories() async {
        
        do {
            try await self.repositoryViewModel?.load(user: "apple")
            self.repositoryViewModel?.fetchMajorRepositories()
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?.count, 3, "stargazers_countが５０以上が３つ存在する")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[0].name, "ccc", "stargazers_countが５０")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[1].name, "ddd", "stargazers_countが５１")
            XCTAssertEqual(self.repositoryViewModel?.majorRepositories?[2].name, "eee", "stargazers_countが５２")
        } catch {
            
        }
        
    }
}

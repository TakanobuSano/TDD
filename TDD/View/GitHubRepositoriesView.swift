//
//  GitHubRepositoriesView.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/03.
//

import SwiftUI

struct GitHubRepositoriesView: View {
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @StateObject var repositoryViewModel: GitHubRepositoryViewModel
    var countOfmajorRepositories = 1
    @EnvironmentObject var dialogModel: DialogModel
    
    var body: some View {
        List(self.repositoryViewModel.majorRepositories ?? [], id: \.name) { item in
            Text(item.name)
        }
        .navigationTitle(repositoryViewModel.userName)
        .task {
            /// クロージャ
            dialogModel.dialogType = .loading
            self.repositoryViewModel.load(user: "apple") {error in
                if error != nil {
                    showingAlert = true
                    self.alertMessage = String(describing: error)
                }
                self.repositoryViewModel.fetchMajorRepositories()
                dialogModel.dialogType = .none
            }
        }
        .refreshable {
            /// Swift Concurrencyのasync/await
            dialogModel.dialogType = .loading
            do {
                try await self.repositoryViewModel.load(user: "google")
            } catch {
                showingAlert = true
                self.alertMessage = String(describing: error)
            }
            self.repositoryViewModel.fetchMajorRepositories()
            dialogModel.dialogType = .none
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct GitHubRepositoriesView_Previews: PreviewProvider {
        
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

    static var previews: some View {
        
        /// モック
        let mockRepositories: [GitHubRepository] = [
            GitHubRepository(id: 0, stargazers_count: 48, name: "aaa"),
            GitHubRepository(id: 1, stargazers_count: 49, name: "bbb"),
            GitHubRepository(id: 2, stargazers_count: 50, name: "ccc"),
            GitHubRepository(id: 3, stargazers_count: 51, name: "ddd"),
            GitHubRepository(id: 4, stargazers_count: 52, name: "eee"),
        ]
        
        let mockAPIClient = MockGithubAPIClient(repositories: mockRepositories)
        let repositoryViewModel = GitHubRepositoryViewModel(client: mockAPIClient)

        GitHubRepositoriesView(repositoryViewModel: repositoryViewModel)
            .environmentObject({ () -> DialogModel in
                let envObj = DialogModel()
                return envObj
            }() )
    }
}

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
    @ObservedObject var repositoryManager: GitHubRepositoryManager
    var countOfmajorRepositories = 1
    
    init(repositoryManager: GitHubRepositoryManager = GitHubRepositoryManager()) {
        self.repositoryManager = repositoryManager
    }

    var body: some View {
        List(self.repositoryManager.majorRepositories ?? [], id: \.name) { item in
            Text(item.name)
        }
        .navigationTitle(repositoryManager.userName)
        .task {
            /// クロージャ
            self.repositoryManager.load(user: "apple") {error in
                if error != nil {
                    showingAlert = true
                    self.alertMessage = String(describing: error)
                }
                self.repositoryManager.fetchMajorRepositories()
            }
        }
        .refreshable {
            /// Swift Concurrencyのasync/await
            do {
                try await self.repositoryManager.load(user: "google")
            } catch {
                showingAlert = true
                self.alertMessage = String(describing: error)
            }
            self.repositoryManager.fetchMajorRepositories()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct GitHubRepositoriesView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubRepositoriesView()
    }
}

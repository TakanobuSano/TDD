//
//  ContentView.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel = ContentViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: GitHubRepositoriesView()) {
                Text("GitHubRepositoris")
            }
            .navigationTitle(viewModel.text)
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}

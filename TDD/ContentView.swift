//
//  ContentView.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @ObservedObject var viewModel: ContentViewModel
    @EnvironmentObject var dialogModel: DialogModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
        self.viewModel = viewModel
    }
    
    var repositoryViewModel: GitHubRepositoryViewModel = GitHubRepositoryViewModel()
    
    var body: some View {
        
        TabView(selection: $selection) {
            NavigationView {
                NavigationLink(destination: GitHubRepositoriesView(repositoryViewModel: repositoryViewModel)) {
                    Text("GitHubRepositoris")
                }
                .navigationTitle(viewModel.text)
            }.navigationViewStyle(.stack)
                .tabItem {
                    Image(systemName: "house")
                    Text("HOME")
                }
                .tag(1)

            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(2)
        }
        .onChange(of: selection) { selection in
            switch selection {
            case 1:
                print("HOMEがタップされた")
            case 2:
                print("Settingsがタップされた")
            default:
                break
            }
        }
        // スプラッシュ画面
        .splashView {
            // カスタムビュー
            ZStack {
                   Color.blue
                   Text("スプラッシュ")
                     .fontWeight(.bold)
                     .font(.system(size: 24))
                     .foregroundColor(.white)
                 }
            .edgesIgnoringSafeArea(.all)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}

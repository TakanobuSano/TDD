//
//  TDDApp.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import SwiftUI

@main
struct TDDApp: App {
    
    // アプリ起動時にDialogModelをインスタンス
    @StateObject var dialogModel = DialogModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
            // アプリのコンテンツビュー（一番トップの親ビュー）に共有オブジェクトとして登録し、ダイアログのモディファイアを適応
                .environmentObject(dialogModel)
                .dialog(dialogModel)
        }
    }
}

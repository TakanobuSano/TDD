//
//  ContentViewModel.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var text: String = "Hello, world"
        
    init(text: String = "Hello, world") {
//        self.echo(message: text) { message in
//            print(message)
//        }
    }
    
//    func echo(message: String, _ handler: @escaping(String) -> Void) {
//        DispatchQueue.global().async {
//            Thread.sleep(forTimeInterval: 0)
//            
//            DispatchQueue.global().async {
//                handler("\(message)!")
//                DispatchQueue.main.async {
//                    self.text = "\(message)!"
//                }
//            }
//        }
//    }
    
}

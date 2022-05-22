//
//  DialogModifier.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/22.
//  https://www.keaura.com/blog/modal-dialogs-with-swiftui

import SwiftUI

struct DialogModifier: ViewModifier {
    @ObservedObject var dialogModel: DialogModel
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    switch dialogModel.dialogType {
                    case .loading:
                        VStack {
                            Text("Loading...")
                            ActivityIndicator(isAnimating: .constant(true), style: .large)
                        }
                        
                    default:
                        EmptyView()
                    }
                }
            )
    }
}

extension View {
    func dialog(_ model: DialogModel) -> some View {
        self.modifier(DialogModifier(dialogModel: model))
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

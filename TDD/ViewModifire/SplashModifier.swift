//
//  SplashModifier.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/22.
//  https://swiftuirecipes.com/blog/swiftui-splash-screen

import SwiftUI

private let defaultTimeout: TimeInterval = 2.5

struct SplashModifier<SplashContent: View>: ViewModifier {
    private let timeout: TimeInterval
    private let splashContent: () -> SplashContent
    
    @State private var isActive = true
    
    init(timeout: TimeInterval = defaultTimeout,
         @ViewBuilder splashContent: @escaping () -> SplashContent) {
        self.timeout = timeout
        self.splashContent = splashContent
    }
    
    func body(content: Content) -> some View {
        if isActive {
            splashContent()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
                        withAnimation {
                            self.isActive = false
                        }
                    }
                }
        } else {
            content
        }
    }
}

extension View {
    func splashView<SplashContent: View>(
        timeout: TimeInterval = defaultTimeout,
        @ViewBuilder splashContent: @escaping () -> SplashContent
    ) -> some View {
        self.modifier(SplashModifier(timeout: timeout, splashContent: splashContent))
    }
}

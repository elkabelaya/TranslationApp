//
//  SizeReader.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

fileprivate struct SizeReader: ViewModifier {
    var onComplete: (CGSize) -> ()
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { g in
                    Color.clear.onAppear {
                        onComplete(g.size)
                    }
                }
            )
    }
}

extension View {
    public func readSize(onComplete: @escaping(CGSize) -> ()) -> some View {
        modifier(SizeReader(onComplete: onComplete))
    }
}


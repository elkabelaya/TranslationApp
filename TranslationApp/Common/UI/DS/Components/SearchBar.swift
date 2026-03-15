//
//  SearchBar.swift
//  TranslationApp
//
//  Created by elka belaya  on 07.03.2026.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let placeholder: LocalizedStringResource

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.appPrimaryText)

            TextField(placeholder, text: $text)
                .foregroundColor(.appPrimaryText)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.appPrimaryText)
                }
            }
        }
        .paddings(.xs, .s,.xs, .s)
        .background(.appPrimaryBackground)
        .overlay(
            RoundedRectangle(cornerRadius: AppDimens.Corners.xs.rawValue)
                .stroke(.appPrimaryText, lineWidth: 2)
        )
    }
}

#Preview {
    @Previewable @State var emptyText: String = ""
    @Previewable @State var text: String = "Text"
    VStack {
        SearchBar(text: $emptyText, placeholder: "placeholder")
        SearchBar(text: $text, placeholder: "placeholder")
    }
    .padding(10)
}

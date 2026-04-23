//
//  LanguagesListView.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

struct LanguagesListView: View {
    @State var viewModel: LanguagesListViewModelProtocol

    var body: some View {
        VStack(spacing: .s) {
            SearchBar(text: $viewModel.filter, placeholder: .LanguagesList.searchPlaceholder)
                .paddings(.s,.l,.s,.l)
            List(viewModel.languages, id: \.id) { language in
                Button(action: {
                    viewModel.onSelectLanguage(language)
                }){
                    Text(language.name)
                }
                .textListRow()
            }
            .appListStyle()
            .font(.textS)
            .foregroundStyle(.appPrimaryText)
            .background(.appSecondaryBackground)
            
        }
        .background(.appSecondaryBackground)
        .cornerRadius(24)
        .paddings(.s,.l,.s,.l)
        .downShadow()
    }
}

#Preview {
    LanguagesListView(viewModel: MockLanguagesListViewModel())
}

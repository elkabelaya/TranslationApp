//
//  FavoritesView.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

struct FavoritesView<ViewModel: FavoritesViewModelProtocol>: View {
    @State var viewModel: ViewModel

    var body: some View {
        SavedList(
            items: $viewModel.items,
            onClick: viewModel.onFavoriteClick
        )
        .toolbar(title: .Favorites.title,
                 leading: [
                    ToolBarButton(
                        item: .icon(.icArrowBack),
                        action: viewModel.onBack)
                 ]
        )
    }
}

#Preview {
    FavoritesView(
        viewModel: MockFavoritesViewModel(
            items: Translation.mocks
        )
    )
}

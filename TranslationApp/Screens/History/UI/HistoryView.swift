//
//  HistoryView.swift
//  TranslationApp
//
//  Created by elka belaya  on 17.03.2026.
//

import SwiftUI

struct HistoryView<ViewModel: HistoryViewModelProtocol>: View {
    @State var viewModel: ViewModel

    var body: some View {
        SavedList(
            items: $viewModel.items,
            onClick: viewModel.onFavoriteClick
        )
        .toolbar(title: .History.title,
                 leading: [
                    ToolBarButton(
                        item: .icon(.icArrowBack),
                        action: viewModel.onBack)
                 ]
        )
    }
}

#Preview {
    HistoryView(viewModel: MockHistoryViewModel())
}

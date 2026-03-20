//
//  ContentView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

struct MainView: View {
    @State var viewModel: MainViewModelProtocol
    @State var shareHeight: CGFloat = 0
    
    var body: some View {
        VStack(spacing:.l) {
            LanguagesCardView(lngFrom: viewModel.fromLng?.name,
                              lngTo: viewModel.toLng?.name,
                              iconFrom: viewModel.fromIconPath,
                              iconTo: viewModel.toIconPath,
                              onLngFromClick: viewModel.onLngFromClick,
                              onLngToClick: viewModel.onLngToClick,
                              onSwapClick: viewModel.onSwapClick
            )
            InputCardView(lngName: viewModel.fromLng?.name,
                          isListening: viewModel.isListening,
                          input: $viewModel.fromText,
                          onLngClick: viewModel.onLngFromClick,
                          onSpeakerClick: viewModel.onFromSpeakerClick,
                          onCloseClick: viewModel.onFromCloseClick,
                          onMicrophoneClick: viewModel.onMicrophoneClick,
                          onTranslateClick: viewModel.onTranslateClick
            )
            if !viewModel.toText.isEmpty {
                TranslateCardView(lngName: viewModel.toLng?.name,
                                  translation: viewModel.toText,
                                  isFavorite: viewModel.isFavorite,
                                  onLngClick: viewModel.onLngToClick,
                                  onSpeakerClick: viewModel.onToSpeakerClick,
                                  onCopyClick: viewModel.onToCopyClick,
                                  onShareClick: viewModel.onToShareClick,
                                  onFavoriteClick: viewModel.onToFavoriteClick
                )
            }
            Spacer()

            
        }
        .padding(AppDimens.Paddings.l.rawValue)
        .toolbar(title: .Main.title,
                 leading: [
                    ToolBarButton(item: .icon(.icMenu), action: {})
                 ]
        )
        .toast(model: $viewModel.toast)
        .sheet(isPresented: $viewModel.showSheet) {
            //TODO refactor navigation to sheet
            switch viewModel.bottomSheet {
            case .languages:
                languagesSheet()
            case .share(let text):
                ActivityViewController(activityItems: [text])
                    .presentationDetents([.medium])
            case .none:
                EmptyView()
            }
        }
        
    }
    
    private func languagesSheet() -> some View {
        VStack(spacing: .s) {
            SearchBar(text: $viewModel.filter, placeholder: .Main.searchPlaceholder)
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
    MainView(viewModel: MockMainViewModel(
        fromLng: .init(id: "0",name: "Spanish"),
        toLng: .init(id: "0",name: "English"),
        fromText: "Hola",
        toText: "Hello")
    )
}

#Preview("BottomSheet") {
    MainView(viewModel: MockMainViewModel(
        fromLng: .init(id: "0",name: "Spanish"),
        toLng: .init(id: "0",name: "English"),
        fromText: "Hola",
        toText: "Hello",
        bottomSheet: .languages)
    )
}




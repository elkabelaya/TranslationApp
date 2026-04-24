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
                    ToolBarButton(
                        item: .icon(.icMenu),
                        action: viewModel.onMenuClick
                    )
                 ]
        )
        .toast(model: $viewModel.toast)        
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




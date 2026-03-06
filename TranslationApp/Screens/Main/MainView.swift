//
//  ContentView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

struct MainView<ViewModel: MainViewModelProtocol>: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing:.l) {
            LanguagesCardView(lngFrom: viewModel.fromLng,
                              lngTo: viewModel.toLng,
                              onLngFromClick: {},
                              onLngToClick: {},
                              onSwapClick: {},
                              onSpeakerClick: {}
            )
            InputCardView(lngName: viewModel.fromLng,
                          input: $viewModel.fromText,
                          onLngClick: {},
                          onSpeakerClick: {},
                          onCloseClick: {},
                          onMicrophoneClick: {},
                          onTranslateClick: {}
            )
            TranslateCardView(lngName: viewModel.toLng,
                              translation: $viewModel.toText,
                              onLngClick: {},
                              onSpeakerClick: {},
                              onCopyClick: {},
                              onShareClick: {},
                              onFavoriteClick: {}
            )

            
        }
        .padding(AppDimens.Paddings.l.rawValue)
        .toolbar(title: .Main.title,
                 leading: [
                    ToolBarButton(item: .icon(.icMenu), action: {})
                 ]
        )
    }
}

#Preview {
    MainView(viewModel: MockMainViewModel(
        fromLng: "Spanish",
        toLng: "English",
        fromText: "Hola",
        toText: "Hello")
    )
}

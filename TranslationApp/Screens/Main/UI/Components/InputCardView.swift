//
//  InputCardView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

struct InputCardView: View {
     var lngName: String?
     var isListening: Bool
     @Binding var input: String
     let onLngClick: () -> Void
     let onSpeakerClick: () -> Void
     let onCloseClick: () -> Void
     let onMicrophoneClick: () -> Void
     let onTranslateClick: () -> Void
    
    var body: some View {
        VStack(spacing: .m) {
            HStack(alignment: .center, spacing: .s ) {
                TextButton(lngName ?? "", .titleM, .appSecondaryText, onLngClick)
                IconButton(.icSpeaker, .s, .appSecondaryText, onSpeakerClick)
                Spacer()
                
                IconButton(.icClose, .s, .appPrimaryText, onCloseClick)
            }
            
            TextField(
                isListening ? .MainComponents.voiceInputPlaceholder : .MainComponents.inputPlaceholder,
                text: $input, axis: .vertical
            )
                .frame(maxHeight: 90)
            Spacer()
            
            HStack(spacing: .zero) {
                FilledIconButton(
                    .icMicrophone,
                    .xl,
                    .plain(.appSecondaryText),
                    onMicrophoneClick
                )
                .if(isListening){ view in
                    view.pulse()
                }
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isListening)
                Spacer()
                Button(.MainComponents.action, action: onTranslateClick)
                    .buttonStyle(.primary)
            }
            
        }
        .paddings(.s, .l,.l,.l)
        .cardBackground(corners: .m)
        .downShadow()
    
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    @Previewable @State var lngName: String = "Spanish"
    @Previewable @State var input: String = "Hola, amigo"
    VStack(spacing: 8){
        InputCardView(
            lngName: lngName,
            isListening: true,
            input: $input,
            onLngClick: {},
            onSpeakerClick: {},
            onCloseClick: {},
            onMicrophoneClick: {},
            onTranslateClick: {}
        )
        .frame(width: 300, height: 200)
        InputCardView(
            lngName: lngName,
            isListening: false,
            input: .constant(""),
            onLngClick: {},
            onSpeakerClick: {},
            onCloseClick: {},
            onMicrophoneClick: {},
            onTranslateClick: {}
        )
        .frame(width: 300, height: 200)
    }
}

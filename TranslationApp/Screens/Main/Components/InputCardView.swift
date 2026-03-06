//
//  InputCardView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

struct InputCardView: View {
     var lngName: String
     @Binding var input: String
     let onLngClick: () -> Void
     let onSpeakerClick: () -> Void
     let onCloseClick: () -> Void
     let onMicrophoneClick: () -> Void
     let onTranslateClick: () -> Void
    
    var body: some View {
        VStack(spacing: .m) {
            HStack(alignment: .center, spacing: .s ) {
                TextButton(lngName, .titleM, .appSecondaryText, onLngClick)
                IconButton(.icSpeaker, .s, .appSecondaryText, onSpeakerClick)
                Spacer()
                
                IconButton(.icClose, .s, .appPrimaryText, onCloseClick)
            }
            
            TextField(.MainComponents.inputPlaceholder, text: $input, axis: .vertical)
                .frame(maxHeight: 90)
            Spacer()
            
            HStack(spacing: .zero) {
                FilledIconButton(.icMicrophone,
                                 .xl,
                                 .plain(.appSecondaryText)
                ) {}
                Spacer()
                Button(.MainComponents.action){}
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
    InputCardView(
        lngName: lngName,
        input: $input,
        onLngClick: {},
        onSpeakerClick: {},
        onCloseClick: {},
        onMicrophoneClick: {},
        onTranslateClick: {}
    )
    .frame(width: 300, height: 200)
}

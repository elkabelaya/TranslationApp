//
//  InputCardView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

struct LanguagesCardView: View {
    var lngFrom: String
    var lngTo: String
    let onLngFromClick: () -> Void
    let onLngToClick: () -> Void
    let onSwapClick: () -> Void
    let onSpeakerClick: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: .s ) {
            TextButton(lngFrom, .titleM, .appPrimaryText, onLngFromClick)
            Spacer()
            IconButton(.icSwap, .s, .appSecondaryText, onSpeakerClick)
            Spacer()
            TextButton(lngTo, .titleM, .appPrimaryText, onLngToClick)
            
        }
        .paddings(.s,.xxl,.s,.xxl)
        .cardBackground(corners: .m)
        .downShadow()
        
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    @Previewable @State var lngFromName: String = "Spanish"
    @Previewable @State var lngToName: String = "English"
    LanguagesCardView(lngFrom: lngFromName,
                      lngTo: lngToName,
                      onLngFromClick: {},
                      onLngToClick: {},
                      onSwapClick: {},
                      onSpeakerClick: {}
    )
    .frame(width: 300, height: 200)
}

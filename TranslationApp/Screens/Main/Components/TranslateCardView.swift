//
//  TranslateCardView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

struct TranslateCardView: View {
     var lngName: String
    @Binding var translation: String
     let onLngClick: () -> Void
     let onSpeakerClick: () -> Void
     let onCopyClick: () -> Void
     let onShareClick: () -> Void
     let onFavoriteClick: () -> Void
    
    var body: some View {
        VStack(spacing: .m) {
            HStack(alignment: .center, spacing: .s ) {
                TextButton(lngName, .titleM, .appSecondaryText, onLngClick)
                IconButton(.icSpeaker, .s, .appSecondaryText, onSpeakerClick)
                Spacer()
            }
            
            Text(translation)
                .frame(maxWidth: .infinity, maxHeight: 90, alignment:.leading)
            
            Spacer()
            
            HStack(spacing: .l) {
                Spacer()
                IconButton(.icCopy, .s, .appSecondaryText, onSpeakerClick)
                IconButton(.icShare, .s, .appSecondaryText, onSpeakerClick)
                IconButton(.icStarBordered, .s, .appSecondaryText, onSpeakerClick)
            }
            
        }
        .paddings(.s, .l,.l,.l)
        .cardBackground(corners: .m)
        .downShadow()
    
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    @Previewable @State var lngName: String = "Spanish"
    @Previewable @State var input: String = "Hola, amigo\nkjh"
    VStack {
        TranslateCardView(
            lngName: lngName,
            translation: $input,
            onLngClick: {},
            onSpeakerClick: {},
            onCopyClick: {},
            onShareClick: {},
            onFavoriteClick: {}
        )
        .frame(width: 300, height: 200)
        
        
    }
}

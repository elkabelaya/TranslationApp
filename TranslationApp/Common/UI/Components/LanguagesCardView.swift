//
//  InputCardView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI

struct LanguagesCardView: View {
    var lngFrom: String?
    var lngTo: String?
    var iconFrom: String?
    var iconTo: String?
    let onLngFromClick: () -> Void
    let onLngToClick: () -> Void
    let onSwapClick: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: .s ) {
            lngImage(iconFrom)
            TextButton(lngFrom ?? "Select", .titleM, .appPrimaryText, onLngFromClick)
            Spacer()
            IconButton(.icSwap, .s, .appSecondaryText, onSwapClick)
            Spacer()
            TextButton(lngTo ?? "Select", .titleM, .appPrimaryText, onLngToClick)
            lngImage(iconTo)
        }
        .paddings(.s,.xs,.s,.xs)
        .cardBackground(corners: .m)
        .downShadow()
        
    }
    
    @ViewBuilder
    private func lngImage(_ path: String?) -> some View {
        if let path {
            SVGImageFromFile(filePath: path)
                .frame(
                    width: AppDimens.Icon.s.rawValue,
                    height: AppDimens.Icon.s.rawValue)
                .clipShape(Circle())
        } else {
            Spacer()
                .frame(width: AppDimens.Icon.s.rawValue)
        }
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 100)) {
    @Previewable @State var lngFromName: String = "Spanish"
    @Previewable @State var lngToName: String = "English"
    LanguagesCardView(lngFrom: lngFromName,
                      lngTo: lngToName,
                      onLngFromClick: {},
                      onLngToClick: {},
                      onSwapClick: {}
    )
    .frame(width: 300, height: 200)
}

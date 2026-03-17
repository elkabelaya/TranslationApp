//
//  SavedTranslationCard.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI

struct SavedTranslationCard: View {
    var translation: Translation
    let onFavoriteClick: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: .xs ) {
            HStack(alignment: .bottom, spacing: .xl) {
                Text(translation.fromCode)
                    .appStyle(.titleM, .appPrimaryText)
                Text(translation.fromText)
                    .appStyle(.textS, .appSecondaryText)
                    .align()
                IconButton(
                    translation.isFavorite ? .icStarFilled :.icStarBordered,
                    .s,
                    .appSecondaryText,
                    onFavoriteClick
                )
            }
            Divider()
                .foregroundStyle(.appDivider)
                .padding(.trailing, AppDimens.Paddings.m.rawValue)
            HStack(alignment: .bottom, spacing: .xl) {
                Text(translation.toCode)
                    .appStyle(.titleM, .appPrimaryText)
                Text(translation.toText)
                    .appStyle(.textS, .appAccentText)
                    .align()
            }
        }
        .paddings(.xxs,.xl,.m,.s)
        .cardBackground(corners: .xs)
        .downShadow()
        
    }

}

#Preview {
    VStack {
        ForEach(Translation.mocks, id:\.id) { mock in
            SavedTranslationCard(
                translation: mock,
                onFavoriteClick: {}
            )
        }
    }.padding()
}

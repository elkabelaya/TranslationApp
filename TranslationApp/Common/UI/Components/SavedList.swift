//
//  SavedList.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//
import SwiftUI
struct SavedList: View {
    @Binding var items: [Translation]
    var onClick:(_ translation: Translation) -> Void

    var body: some View {
        List {
            ForEach(items.enumerated(), id: \.offset) { offset, item  in
                SavedTranslationCard(
                    translation: item) {
                        onClick(item)
                    }
                    .listRow()
            }
            .onDelete(perform: {_ in print("delete")})
        }
        
        .appListStyle()
        .listRowInsets(.bottom, AppDimens.Paddings.xs.rawValue)
        
    }
}
#Preview {
    @Previewable @State var items: [Translation] = Translation.mocks
    SavedList(items: $items){_ in}
}


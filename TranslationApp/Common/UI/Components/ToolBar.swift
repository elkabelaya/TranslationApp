//
//  ToolBar.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//


import SwiftUI
private struct ToolBar: ViewModifier {
    let title: LocalizedStringResource
    let leading:[ToolBarButton]
    let trailing: [ToolBarButton]
    
     func body(content: Content) -> some View {
         NavigationStack {
             VStack(spacing:.zero) {
                 HStack(spacing: 16) {
                     ForEach(Array(leading.enumerated()), id: \.offset) { id, item in
                         getButton(by: item)
                     }
                     Text(self.title)
                         .font(.titleL)
                         .foregroundStyle(.appOnAccentText)
                     Spacer()
                     ForEach(Array(trailing.enumerated()), id: \.offset) { id, item in
                         getButton(by: item)
                     }
                 }
                 .paddings(.zero, .xl, .zero, .xl)
                 .frame(maxWidth: .infinity)
                 .frame(height: 60)
                 .background(.appTertiaryBackground)
                 content
                     .frame(maxHeight: .infinity)
                     .background(Color.appPrimaryBackground)
             }
             
         }
         
     }
    
    private func getButton(by: ToolBarButton) -> some View {
        Group {
            switch by.item {
            case .icon(let image):
                IconButton(image, .m, .appOnAccentText, by.action)
            case .text(let text):
                TextButton(text, .textS, .appOnAccentText, by.action)
            }
        }
    }
 }

enum ToolBarButtonType {
    case icon(ImageResource)
    case text(String)
}

struct ToolBarButton {
    let item: ToolBarButtonType
    let action: () -> Void
}

extension View {
     func toolbar(title: LocalizedStringResource, leading:[ToolBarButton] = [], trailing: [ToolBarButton] = []) -> some View {
         modifier(ToolBar(title: title, leading: leading, trailing: trailing))
    }
}

#Preview(){
    Text("Any View")
    .toolbar(title: "Title",
             leading: [
                ToolBarButton(item: .icon(.icMenu), action: {})
             ],
             trailing: [
                ToolBarButton(item: .text("Delete"), action: {})
             ]
    )
}

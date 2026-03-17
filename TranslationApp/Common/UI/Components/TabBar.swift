//
//  ToolBar.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//


import SwiftUI
enum TabItemType {
    case icon
    case filledIcon
}
struct TabItem {
    let type: TabItemType
    let title: LocalizedStringResource
    let icon: ImageResource
}

private struct TabItemView: View {
    let item: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: isSelected ? .xxxs: .s) {
                switch item.type {
                case .icon:
                    IconButton(item.icon,
                               isSelected ? .m : .s,
                               isSelected ? .appSecondaryText : .appPrimaryText,
                               action
                    )
                    TextButton(item.title,
                               isSelected ? .textS : .textXs,
                               isSelected ? .appSecondaryText: .appPrimaryText,
                               action
                    )
                    if isSelected {
                        RoundedRectangle(cornerRadius: AppDimens.Corners.xs.rawValue)
                            .frame(width: 37, height: 1)
                            .foregroundStyle(.appSecondaryText)
                    }
                case .filledIcon:
                    FilledIconButton(
                        item.icon,
                        .xxl,
                        .gradient(.appTertiaryBackgroundGradient,
                                  .appTertiaryBackground),
                        action
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

private struct CustomTabBarView: ViewModifier {
    @Binding var selectedIndex: Int
    
    private let items: [TabItem]

    init(selectedIndex: Binding<Int>, items: [TabItem]) {
        self._selectedIndex = selectedIndex
        self.items = items
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            content
                .frame(maxHeight: .infinity)
            
            HStack {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    TabItemView(item: item, isSelected: selectedIndex == index) {
                        selectedIndex = index
                    }
                }
            }
            .frame(height: 80)
            .background(.appSecondaryBackground)
            .upShadow()
        }
    }
}

extension View {
    func tabbar(selectedIndex: Binding<Int>, items: [TabItem]) -> some View {
        self.modifier(CustomTabBarView(selectedIndex: selectedIndex, items: items))
    }
}

#Preview {
    @Previewable @State var selectedIndex = 2
    Text("Any View")
        .tabbar(selectedIndex: $selectedIndex, items: [
            TabItem(type: .icon, title: "item1", icon: .icCopy),
            TabItem(type: .filledIcon, title: "item2", icon: .icMicrophone),
            TabItem(type: .icon, title: "item3", icon: .icMicrophone),
    ])
}

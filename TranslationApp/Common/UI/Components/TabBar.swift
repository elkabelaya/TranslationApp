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

struct TabItem<Tabbing:Tabbable> {
    let type: TabItemType
    let title: LocalizedStringResource
    let icon: ImageResource
    let tab: Tabbing
}

private struct TabItemView<Tabbing:Tabbable>: View {
    let item: TabItem<Tabbing>
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

private struct CustomTabBarView<Tabbing: Tabbable>: ViewModifier {
    @Binding var selectedTab: Tabbing
    
    private let items: [TabItem<Tabbing>]

    init(selectedTab: Binding<Tabbing>, items: [TabItem<Tabbing>]) {
        self._selectedTab = selectedTab
        self.items = items
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: .zero) {
            content
                .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            HStack {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    TabItemView(
                        item: item,
                        isSelected: selectedTab == item.tab) {
                            selectedTab = item.tab
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
    func tabbar<Tabbing: Tabbable>(selectedTab: Binding<Tabbing>, items: [TabItem<Tabbing>]) -> some View {
        self.modifier(CustomTabBarView(selectedTab: selectedTab, items: items))
    }
}

#Preview {
    @Previewable @State var selectedIndex: Int? = 2
    Text("Any View")
        .tabbar(selectedTab: $selectedIndex,
                items: [
                    TabItem(type: .icon,
                            title: "item1",
                            icon: .icCopy,
                            tab: 1),
                    TabItem(type: .filledIcon,
                            title: "item2",
                            icon: .icMicrophone,
                            tab: 2),
                    TabItem(type: .icon,
                            title: "item3",
                            icon: .icMicrophone,
                            tab: 3),
    ])
}

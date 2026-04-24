//
//  MenuView.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.04.2026.
//

import SwiftUI

struct MenuView: View {
    @State var viewModel: MenuViewModelProtocol

    var body: some View {
        VStack(alignment: .center, spacing: .xxxxl) {
            title
            content
            Spacer()
            version
        }
        .paddings(.xxl, .xxl, .l, .xxl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.appPrimaryBackground)
    }
    
    var title: some View {
        VStack(alignment: .center, spacing: .l) {
            Image(.sideLogo)
            Text(.Menu.title)
                .font(.titleXL)
                .foregroundStyle(.appPrimaryText)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: .xxl) {
            item(
                .sideShare,
                .Menu.share,
                viewModel.onShareClick
            )
            item(
                .sideRate,
                .Menu.rate,
                viewModel.onRateClick)
            item(
                .sidePrivacy,
                .Menu.privacy,
                viewModel.onPolicyClick)
            item(
                .sideFeedback,
                .Menu.feedback,
                viewModel.onFeedbackClick)
        }
    }
    
    var version: some View {
        Group {
            if let version = viewModel.version {
                Text(.Menu.version(value: version))
                    .font(.textS)
                    .foregroundStyle(.appTertiaryText)
            }
        }
    }
    
    func item(
        _ icon: ImageResource,
        _ key: LocalizedStringResource,
        _ action: @escaping () -> Void) -> some View {
        IconTextButton(
            icon, .s,
            key, .textXL,
            .appPrimaryText,
            action
        )
    }
}

#Preview("In Drawer") {
    @Previewable @State var item: Language? = Language.mock
    Text("Some View")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mint)
        .sideDrawer(item: $item) { item in
            MenuView(viewModel: MockMenuViewModel())
        }
}

#Preview("Full") {
    MenuView(viewModel: MockMenuViewModel())
}

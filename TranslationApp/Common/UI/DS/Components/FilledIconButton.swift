//
//  FilledIconButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI
enum FilledIconButtonType {
    case plain(Color)
    case gradient(Color, Color)
}

struct FilledIconButton: View {
    let icon: ImageResource
    let size: AppDimens.FilledIcon
    let type: FilledIconButtonType
    let action:() -> Void
    
    init(_ icon: ImageResource,
         _ size: AppDimens.FilledIcon,
         _ type: FilledIconButtonType,
         _ action: @escaping () -> Void) {
        self.icon = icon
        self.size = size
        self.type = type
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .center) {
                Circle()
                    .apply() {view in
                        Group {
                            switch type {
                            case .gradient(let startColor, let endColor):
                                view
                                    .foregroundStyle(
                                        .linearGradient(
                                            colors: [startColor, endColor],
                                            startPoint: .topLeading,
                                            endPoint:   .bottomTrailing
                                        ))
                            case .plain(let color):
                                view
                                    .foregroundStyle(color)
                                
                            }
                        }
                    }
                    .size(size)
                Image(icon)
                    .resizable()
                    .renderingMode(.original)
                    .size(size.icon())
                    
            }
        }
    }
 }

#Preview {
    VStack {
        FilledIconButton(.icMicrophone,
                         .xl,
                         .plain(.appTertiaryBackground),
                         {})
        FilledIconButton(.icMicrophone,
                         .xl,
                         .gradient(.appTertiaryBackgroundGradient,
                                   .appTertiaryBackground),
                         {})
    }
        
}

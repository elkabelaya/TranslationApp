//
//  ThumbnailIcon.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.03.2026.
//

import SwiftUI

struct ThumbnailIcon: View {
    var size: AppDimens.Icon
    var corner: AppDimens.Corners
    var image: Image?
    var action: () -> Void
    
    init(size: AppDimens.Icon = .m,
         corner: AppDimens.Corners = .xxs,
         image: Image?,
         action: @escaping () -> Void){
        self.size = size
        self.corner = corner
        self.image = image
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Color.white
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                }
            }
            .size(size)
            .cornerRadius(corner)
        }
    }
}

#Preview {
    VStack {
        ThumbnailIcon(image: Image(systemName: "photo.fill")){}
        ThumbnailIcon(image: nil){}
    }
    .background(.black)
    
}

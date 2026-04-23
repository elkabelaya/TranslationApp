//
//  BoundingBox.swift
//  TranslationApp
//
//  Created by elka belaya  on 24.03.2026.
//

import SwiftUI

struct BoundingBox: View {
    let observation: TextObservation
    let size: CGSize
    
    var body: some View {
        let rect = CGRect(
            x: observation.topLeading.x * size.width - 1,
            y: (1 - observation.topLeading.y) * size.height - 1,
            width: observation.boundingBox.width * size.width + 2,
            height: observation.boundingBox.height * size.height + 2)
        Path { path in
            path.addRoundedRect(
                in: rect,
                cornerSize: CGSize(
                    width: AppDimens.Corners.xs.rawValue,
                    height: AppDimens.Corners.xs.rawValue
                )
            )
        }
        .stroke(.appPrimaryText, lineWidth: 1)
        .shadow(
            color: .appOnAccentText,
            radius: 1,
            x: 1,
            y: 1
        )
        .rotationEffect(
            Angle(degrees: observation.anglePi),
            anchor:.leading
//            anchor: UnitPoint(
//                x: observation.topLeading.x * size.width,
//                y: (1 - observation.topLeading.y) * size.height
//            )
        )
        
    }
}

#Preview {
    @Previewable @State var contentSize: CGSize = .zero
    LinearGradient(
        gradient: Gradient(
            colors: [.white, .black]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    .frame(
        width: 220,
        height: 180
    )
    .readSize { size in
        contentSize = size
    }
    .overlay(alignment: .topLeading) {
        ForEach(TextObservation.mocks) { mock in
            BoundingBox(
                observation: mock,
                size: contentSize
            )
        }
    }
}

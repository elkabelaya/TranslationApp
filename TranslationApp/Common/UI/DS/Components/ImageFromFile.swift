//
//  ImageFromFile.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//

import SwiftUI
import UIKit

struct SVGImageFromFile: View {
    let filePath: String
    @State private var uiImage: UIImage?
    
    var body: some View {
        _ = Self._printChanges()
        return Image(uiImage: uiImage ?? UIImage())
        .resizable()
        .task(updateImage)
        .onChange(of: self, updateImage)
        
        func updateImage() {
            uiImage = nil
                if let url = URL(string: filePath),
                   let data = try? Data(contentsOf: url),
                   let svg = SVG(data){
                    let render = UIGraphicsImageRenderer(size: svg.size)
                                uiImage = render.image { context in
                                    svg.draw(in: context.cgContext)
                                }
                    
                }
        }
    }
}

extension SVGImageFromFile: Equatable {
    static func == (lhs: SVGImageFromFile, rhs: SVGImageFromFile) -> Bool {
        lhs.filePath == rhs.filePath
    }
    
    
}

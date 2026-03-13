//
//  AppButton.swift
//  TranslationApp
//
//  Created by elka belaya  on 04.03.2026.
//

import SwiftUI

extension List {
    public func appListStyle() -> some View {
        self
            .listStyle(.plain)
    }
    
}

extension View {
    func listRow() -> some View {
        self
            .listRowSeparator(Visibility.hidden, edges: .bottom)
            .listRowBackground(Color.appSecondaryBackground)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center
            )
            
            
    }
    
    func textListRow() -> some View {
        self
            .listRow()
            .font(.textS)
            .foregroundStyle(.appPrimaryText)
            
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var text: String = ""
    VStack {
        List {
            Text("some one")
                .listRow()
            Text("some two")
                .listRow()
        }
        .appListStyle()
        .searchable(text: $text, prompt: "placeholder")
        .downShadow()
        .padding(8)
        
        
        List {
            Text("some one")
                .textListRow()
            Text("some two")
                .textListRow()
        }
        .appListStyle()
        .downShadow()
        .padding(8)
    }
}

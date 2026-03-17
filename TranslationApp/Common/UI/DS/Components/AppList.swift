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
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center
            )
            .buttonStyle(PlainButtonStyle())
            
            
    }
    
    func textListRow(_ background: Color? = .appSecondaryBackground) -> some View {
        self
            .listRowSeparator(Visibility.hidden, edges: .bottom)
            .listRowBackground(background)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .center
            )
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

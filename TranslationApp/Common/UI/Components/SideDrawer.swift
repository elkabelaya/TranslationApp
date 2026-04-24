//
//  SideDrawer.swift
//  TranslationApp
//
//  Created by elka belaya  on 23.04.2026.
//

import SwiftUI

fileprivate struct SideDrawerModifier<Item: Identifiable & Equatable, DrawerContent: View>: ViewModifier {
    @Binding public var item: Item?
    let drawerContent: (Item) -> DrawerContent
    let animation: Animation

    public init(
        item: Binding<Item?>,
        animation: Animation,
        @ViewBuilder drawerContent: @escaping (Item) -> DrawerContent
    ) {
        self._item = item
        self.animation = animation
        self.drawerContent = drawerContent
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .iflet(item) { view, _ in
                    view
                        .disabled(true)
                        .dim()
                        .onTapGesture {
                            withAnimation {
                                hide()
                            }
                        }
                }
            if let item {
                drawer(item: item)
                    .transition(.move(edge: .leading))
                    .animation(animation, value: isPresented())
            }
        }
    }
    
    func drawer(item: Item) -> some View {
        GeometryReader { geo in
        drawerContent(item)
            .frame(width: geo.size.width * 0.8)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let threshold: CGFloat = 80
                        if gesture.translation.width < -threshold { hide() }
                    }
            )            
        }
    }
    func isPresented() -> Bool {
        item != nil
    }
    
    func hide() {
        item = nil
    }
}

extension View {
    func sideDrawer<Item, Content>(
        item: Binding<Item?>,
        animation: Animation = .linear(duration: 5),
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View where Item : Identifiable & Equatable, Content : View {
        self.modifier(SideDrawerModifier(
            item: item,
            animation: animation,
            drawerContent: content
        ))
    }
    
    func dim() -> some View {
        self
        .overlay(
            Color.black.opacity(0.4)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    @Previewable @State var item: Language? = Language.mock
    Text("Some View")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mint)
        .sideDrawer(item: $item) { item in
            Text(item.name)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
               
        }
}

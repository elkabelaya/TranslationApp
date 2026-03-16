//
//  Toast.swift
//  TranslationApp
//
//  Created by elka belaya  on 15.03.2026.
//
import SwiftUI


fileprivate struct ToastView: View {
    let model: ToastModel
    
    var body: some View {
        HStack(spacing: 12) {
            Text(model.message)
                .foregroundColor(.appOnAccentText)
        }
        .paddings(.s,.xl,.s,.xl)
        .background(.appTertiaryBackground)
        .cornerRadius(.m)
        .downShadow()
    }
}

struct ToastModel {
    let message: LocalizedStringResource
}

fileprivate struct ToastModifier: ViewModifier {
    @Binding var model: ToastModel?
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .iflet(model) { view, model  in
                view
                    .overlay(
                        ToastView(model: model)
                            .onTapGesture {
                                self.model = nil
                            }
                            .padding(.bottom, 50)
                            .transition(
                                .opacity.animation(
                                    .easeIn(duration: 0.3)
                                )
                            )
                            .onAppear {
                                if duration > 0 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                        withAnimation(
                                            .easeOut(duration: 0.3)
                                        ) {
                                            self.model = nil
                                        }
                                    }
                                }
                            },
                        alignment: .bottom
                    )
            }
    }
}

extension View {
    func toast(model: Binding<ToastModel?>, duration: Double = 2.0) -> some View {
        self.modifier(ToastModifier(model: model, duration: duration))
    }
}


#Preview {
    Text("Any View")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toast(model: .constant(ToastModel(message: "Message")))
}

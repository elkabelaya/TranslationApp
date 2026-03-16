//
//  ActivityView.swift
//  TranslationApp
//
//  Created by elka belaya  on 16.03.2026.
//

import SwiftUI
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    var completionWithItemsHandler: UIActivityViewController.CompletionWithItemsHandler? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        controller.completionWithItemsHandler = completionWithItemsHandler
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

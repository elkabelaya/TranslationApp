//
//  CameraScanner.swift
//  LiveTextAPISample
//
//  Created by elka belaya  on 09.02.2026.
//
import SwiftUI

struct CameraScanner: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var startScanning: Bool
    @Binding var scanResult: String
    var body: some View {
        NavigationView {
            CameraScannerViewController(startScanning: $startScanning,
                                        scanResult: $scanResult
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .interactiveDismissDisabled(true)
        }
    }
}

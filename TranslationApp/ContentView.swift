//
//  ContentView.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import SwiftUI
import VisionKit

enum Tabs: Int {
    case menu
    case translate
    case main
}

struct ContentView: View {
    @State var selectedTab: Int = Tabs.main.rawValue
    var body: some View {
        ZStack {
            switch selectedTab {
            case Tabs.main.rawValue:
                MainView(viewModel: MainViewModel())
            default:
                Text("TODO")
            }
        }
        .tabbar(selectedIndex: $selectedTab,
                items: [TabItem(type: .filledIcon,
                                title: "main",
                                icon: .icTranslate)
                ]
        )
    }
}
//    @State private var scanResults: String = ""
//    @State private var showDeviceNotCapacityAlert = false
//    @State private var showCameraScannerView = false
//    @State private var isDeviceCapacity = false
//    
//    var body: some View {
//        VStack {
//            Text(scanResults)
//                .padding()
//            Button {
//                if isDeviceCapacity {
//                    self.showCameraScannerView = true
//                } else {
//                    self.showDeviceNotCapacityAlert = true
//                }
//            } label: {
//                Text("Tap to Scan Documents")
//                    .foregroundColor(.white)
//                    .frame(width: 300, height: 50)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .alert("Scanner Unavailable", isPresented: $showDeviceNotCapacityAlert, actions: {})
//        .sheet(isPresented: $showCameraScannerView) {
//                    CameraScanner(startScanning: $showCameraScannerView, scanResult: $scanResults)
//                }
//        .onAppear {
//                isDeviceCapacity = (DataScannerViewController.isSupported && DataScannerViewController.isAvailable)
//            }
//    }
//}

#Preview {
    ContentView()
}

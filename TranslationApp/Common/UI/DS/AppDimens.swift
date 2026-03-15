//
//  AppDimens.swift
//  TranslationApp
//
//  Created by elka belaya  on 03.03.2026.
//

import CoreFoundation

enum AppDimens {
    enum Corners: CGFloat {
        case xs = 12.0
        case m = 16.0
        case l = 24.0
        case xxl = 50.0
        case xxxl = 100.0
    }
    
    enum Paddings: CGFloat {
        case zero = 0
        case xxxs = 4
        case xxs = 6
        case xs = 8
        case s = 12.0
        case m = 16
        case l = 20
        case xl = 22
        case xxl = 40
    }
    
    enum Font: CGFloat {
        case xs = 12.0
        case s = 14.0
        case m = 16.0
        case l = 18.0
        case xl = 20.0
    }
    
    enum Icon: CGFloat {
        case s = 24
        case m = 32
    }
    enum FilledIcon: CGFloat {
        case xl = 40
        case xxl = 48
        
        func icon() -> CGFloat {
            24
        }
        
        func paddings() -> CGFloat {
            (self.rawValue - icon())/2
        }
    }
    
    enum Image {
        static var m = 100
        static var xl = 140
    }
}

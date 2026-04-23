//
//  PathExtensions.swift
//  TranslationApp
//
//  Created by elka belaya  on 27.03.2026.
//

import SwiftUI
import CoreGraphics

extension Path {
    mutating func addRoundedCorner(from p0: CGPoint,
                                   to   p1: CGPoint,
                                   via  p2: CGPoint,
                                   radius r0: CGFloat) {
        let d1 = CGVector(dx: p1.x - p0.x, dy: p1.y - p0.y)
        let d2 = CGVector(dx: p2.x - p1.x, dy: p2.y - p1.y)
        let l1 = hypot(d1.dx, d1.dy)
        let l2 = hypot(d2.dx, d2.dy)
        let t0 = min(r0 / l1, 0.5)
        let t1 = min(r0 / l2, 0.5)
        let a0 = CGPoint(x: p1.x - d1.dx * t0, y: p1.y - d1.dy * t0)
        let a1 = CGPoint(x: p1.x + d2.dx * t1, y: p1.y + d2.dy * t1)
        let n = CGVector(dx: -d1.dy, dy: d1.dx).normalized()
        let center = CGPoint(x: p1.x + n.dx * r0, y: p1.y + n.dy * r0)
        let startAngle = atan2(a0.y - center.y, a0.x - center.x)
        let endAngle   = atan2(a1.y - center.y, a1.x - center.x)
        self.addLine(to: a0)
        self.addArc(center: center,
                    radius: r0,
                    startAngle: Angle(radians: Double(startAngle)),
                    endAngle:   Angle(radians: Double(endAngle)),
                    clockwise: false)
        self.addLine(to: a1)
    }
}

extension CGVector {
    var length: CGFloat { hypot(dx, dy) }
    func normalized() -> CGVector { let l = length; return CGVector(dx: dx / l, dy: dy / l) }
}

struct RoundedQuadrilateral: View {
    let p0 = CGPoint(x: 50,  y: 100)
    let p1 = CGPoint(x: 300, y: 80)
    let p2 = CGPoint(x: 320, y: 300)
    let p3 = CGPoint(x: 80,  y: 350)
    let radius: CGFloat = 20
    
    var body: some View {
        Path { path in
            path.move(to: p3)
            path.addRoundedCorner(from: p3, to: p2, via: p1, radius: radius)
            //path.addRoundedCorner(from: p2, to: p0, via: p3, radius: radius)
//            path.addRoundedCorner(from: p1, to: p2, via: p3, radius: radius)
//            path.addRoundedCorner(from: p2, to: p3, via: p0, radius: radius)
        }
        .stroke(Color.blue, lineWidth: 3)
        .frame(width: 400, height: 400)
    }
}

#Preview {
    RoundedQuadrilateral()
}

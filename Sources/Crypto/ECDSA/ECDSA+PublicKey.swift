//
//  ECDSA+PublicKey.swift
//  
//
//  Created by Rafael Stark on 2/15/21.
//

import Foundation

extension ECDSA {
    public struct PublicKey {

        public let point: Point

        public let curve: Curve

        public init(point: Point, curve: Curve) {
            self.point = point
            self.curve = curve
        }

        public init(pem string: String, curve: Curve) {
            let key = string.components(separatedBy: .newlines).dropFirst().dropLast().joined()
            let data = Data(base64Encoded: key)!.suffix(curve.length * 2)
            self.point = Point(
                .init(BigUInteger(data.prefix(curve.length))),
                .init(BigUInteger(data.suffix(curve.length)))
            )
            self.curve = curve
        }
    }
}

//
//  ECDSA+Point.swift
//  
//
//  Created by Rafael Stark on 2/14/21.
//

import Foundation

extension ECDSA {
    public struct Point {

        public let x: BigInteger

        public let y: BigInteger

        public let z: BigInteger

        public init(_ x: BigInteger = 0, _ y: BigInteger = 0, _ z: BigInteger = 0) {
            self.x = x
            self.y = y
            self.z = z
        }

        public var isAtInfinity: Bool {
            return y == 0
        }
    }
}

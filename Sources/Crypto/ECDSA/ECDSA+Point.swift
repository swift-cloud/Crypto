//
//  File.swift
//  
//
//  Created by Rafael Stark on 2/14/21.
//

import Foundation

extension ECDSA {
    public class Point {

        public var x: CS.BigInt
        public var y: CS.BigInt
        public var z: CS.BigInt

        public init(_ x: CS.BigInt = CS.BigInt(0), _ y: CS.BigInt = CS.BigInt(0), _ z: CS.BigInt = CS.BigInt(0)) {
            self.x = x
            self.y = y
            self.z = z
        }

        func isAtInfinity() -> Bool {
            return self.y == CS.BigInt(0)
        }
    }
}

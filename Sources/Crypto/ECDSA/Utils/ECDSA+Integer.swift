//
//  File.swift
//  
//
//  Created by Rafael Stark on 2/17/21.
//

import Foundation

extension ECDSA {
    class RandomInteger {

        /**
         - Parameter minimum: minimum value of the integer
         - Parameter maximum: maximum value of the integer
         - Returns: integer x in the range: minimum <= x <= maximum
         */
        public static func lessThan(max: CS.BigInt) -> CS.BigInt {
            return .init(CS.BigUInt.randomInteger(lessThan: .init(max)))
        }

        internal static func getBytesNeeded(_ request: CS.BigInt) -> (Int, CS.BigInt) {
            var range = request
            var bitsNeeded = 0
            var bytesNeeded = 0
            var mask = CS.BigInt(1)

            while (range > 0) {
                if (bitsNeeded % 8 == 0) {
                    bytesNeeded += 1
                }
                bitsNeeded += 1
                mask = (mask << 1) | CS.BigInt(1)
                range = range >> 1
            }
            return (bytesNeeded, mask)
        }
    }
}
